#!/bin/bash

# Script de despliegue para Cohorte Vida y Paz
# Para usar en servidor Ubuntu

set -e

echo "=========================================="
echo "Cohorte Vida y Paz - Script de Despliegue"
echo "=========================================="
echo ""

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Función para imprimir mensajes
print_message() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Verificar si se ejecuta como root
if [ "$EUID" -eq 0 ]; then 
    print_warning "No se recomienda ejecutar este script como root"
    read -p "¿Continuar? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Verificar Docker
print_message "Verificando Docker..."
if ! command -v docker &> /dev/null; then
    print_error "Docker no está instalado"
    exit 1
fi
print_message "Docker instalado: $(docker --version)"

# Verificar Docker Compose
print_message "Verificando Docker Compose..."
if command -v docker &> /dev/null; then
    # Verificar si está docker compose (nuevo formato)
    if docker compose version &> /dev/null 2>&1; then
        DOCKER_COMPOSE="docker compose"
        COMPOSE_VERSION=$(docker compose version --short 2>&1)
        print_message "Docker Compose instalado: $COMPOSE_VERSION (nuevo formato)"
    # Verificar si está docker-compose (formato antiguo)
    elif command -v docker-compose &> /dev/null; then
        DOCKER_COMPOSE="docker-compose"
        COMPOSE_VERSION=$(docker-compose --version 2>&1)
        print_message "Docker Compose instalado: $COMPOSE_VERSION (formato antiguo)"
    else
        print_error "Docker Compose no está instalado"
        exit 1
    fi
else
    print_error "Docker Compose no está instalado"
    exit 1
fi

# Verificar configuración de Traefik
print_message "Verificando configuración de Traefik..."
if [ ! -f /etc/traefik/traefik.yml ]; then
    print_warning "No se encontró configuración de Traefik en /etc/traefik/traefik.yml"
    print_warning "Asegúrate de configurar Traefik antes de continuar"
    read -p "¿Continuar? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Verificar red de Traefik
print_message "Verificando red de Traefik..."
if ! docker network inspect traefik-network &> /dev/null; then
    print_message "Creando red traefik-network..."
    docker network create traefik-network
fi

# Verificar archivo .env
print_message "Verificando archivo .env..."
if [ ! -f .env ]; then
    print_warning "Archivo .env no encontrado"
    if [ -f .env.example ]; then
        print_message "Creando .env desde .env.example..."
        cp .env.example .env
        print_warning "Por favor, edita .env y configura las variables necesarias"
        read -p "Presiona Enter para editar .env..."
        ${EDITOR:-nano} .env
    else
        print_error "No se encontró .env.example"
        exit 1
    fi
fi

# Verificar directorio images
print_message "Verificando directorio images..."
if [ ! -d images ]; then
    print_message "Creando directorio images..."
    mkdir -p images
    touch images/.gitkeep
fi

# Detener contenedores existentes
print_message "Deteniendo contenedores existentes..."
$DOCKER_COMPOSE down 2>/dev/null || true

# Construir imágenes
print_message "Construyendo imágenes Docker..."
$DOCKER_COMPOSE build --no-cache

# Levantar contenedores
print_message "Levantando contenedores..."
$DOCKER_COMPOSE up -d

# Verificar estado
print_message "Verificando estado de los contenedores..."
sleep 5
$DOCKER_COMPOSE ps

# Verificar logs
print_message "Verificando logs..."
$DOCKER_COMPOSE logs --tail=20

# Prueba de conexión
print_message "Probando conexión..."
if curl -s -o /dev/null -w "%{http_code}" http://localhost | grep -q "200"; then
    print_message "✓ Sitio web accesible en http://localhost"
else
    print_error "✗ Error al acceder al sitio web"
    print_message "Verifica los logs con: docker-compose logs -f"
fi

echo ""
print_message "=========================================="
print_message "Despliegue completado"
print_message "=========================================="
echo ""
print_message "Comandos útiles:"
print_message "  Ver estado: $DOCKER_COMPOSE ps"
print_message "  Ver logs: $DOCKER_COMPOSE logs -f"
print_message "  Reiniciar: $DOCKER_COMPOSE restart"
print_message "  Detener: $DOCKER_COMPOSE down"
echo ""
print_message "Dashboard de Traefik: http://traefik.cohortevidaypaz.com.co:8080"
print_message "Sitio web: https://www.cohortevidaypaz.com.co"
echo ""
