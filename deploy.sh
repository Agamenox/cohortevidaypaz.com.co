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
    print_warning "¿Cómo deseas continuar?"
    print_warning "  1. Configurar Traefik automáticamente"
    print_warning "  2. Usar modo standalone (sin Traefik)"
    print_warning "  3. Cancelar"
    read -p "Selecciona una opción (1/2/3): " -n 1 -r
    echo
    if [[ $REPLY == "1" ]]; then
        print_message "Ejecutando script de configuración de Traefik..."
        if [ -f setup-traefik.sh ]; then
            chmod +x setup-traefik.sh
            sudo ./setup-traefik.sh
            print_message "Configuración de Traefik completada"
        else
            print_error "No se encontró el script setup-traefik.sh"
            print_warning "Por favor, configura Traefik manualmente:"
            print_warning "  sudo mkdir -p /etc/traefik"
            print_warning "  sudo touch /etc/traefik/acme.json"
            print_warning "  sudo chmod 600 /etc/traefik/acme.json"
            print_warning "  docker network create traefik-network"
            print_warning "  sudo nano /etc/traefik/traefik.yml"
            read -p "¿Continuar después de configurar manualmente? (y/n) " -n 1 -r
            echo
            if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                exit 1
            fi
        fi
    elif [[ $REPLY == "2" ]]; then
        print_message "Usando modo standalone (sin Traefik)..."
        COMPOSE_FILE="docker-compose.standalone.yml"
        TRAEFIK_ENABLED="false"
    else
        print_message "Cancelando despliegue..."
        exit 1
    fi
fi

# Verificar red de Traefik (solo si está habilitado)
if [ "$TRAEFIK_ENABLED" != "false" ]; then
    print_message "Verificando red de Traefik..."
    if ! docker network inspect traefik-network &> /dev/null; then
        print_message "Creando red traefik-network..."
        docker network create traefik-network
    fi
else
    print_message "Modo standalone: Omitiendo configuración de Traefik"
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

# IMPORTANTE: Eliminar archivo .env si existe para evitar warnings de Docker
print_message "Preparando entorno de Docker..."
if [ -f .env ]; then
    print_warning "Renombrando .env a .env.bak para evitar warnings de Docker"
    mv .env .env.bak
    print_message "Docker no usará el archivo .env para evitar warnings de variables"
fi

# Detener contenedores existentes
print_message "Deteniendo contenedores existentes..."
$DOCKER_COMPOSE -f $COMPOSE_FILE down 2>/dev/null || true

# Construir imágenes
print_message "Construyendo imágenes Docker..."
$DOCKER_COMPOSE -f $COMPOSE_FILE build

# Levantar contenedores
print_message "Levantando contenedores..."
$DOCKER_COMPOSE -f $COMPOSE_FILE up -d

# Verificar estado
print_message "Verificando estado de los contenedores..."
sleep 5
$DOCKER_COMPOSE -f $COMPOSE_FILE ps

# Verificar logs
print_message "Verificando logs..."
$DOCKER_COMPOSE -f $COMPOSE_FILE logs --tail=20

# Prueba de conexión
print_message "Probando conexión..."
if curl -s -o /dev/null -w "%{http_code}" http://localhost | grep -q "200"; then
    print_message "✓ Sitio web accesible en http://localhost"
else
    print_error "✗ Error al acceder al sitio web"
    print_message "Verifica los logs con: $DOCKER_COMPOSE -f $COMPOSE_FILE logs -f"
fi

echo ""
print_message "=========================================="
print_message "Despliegue completado"
print_message "=========================================="
echo ""
print_message "Comandos útiles:"
print_message "  Ver estado: $DOCKER_COMPOSE -f $COMPOSE_FILE ps"
print_message "  Ver logs: $DOCKER_COMPOSE -f $COMPOSE_FILE logs -f"
print_message "  Reiniciar: $DOCKER_COMPOSE -f $COMPOSE_FILE restart"
print_message "  Detener: $DOCKER_COMPOSE -f $COMPOSE_FILE down"
echo ""
if [ "$TRAEFIK_ENABLED" == "false" ]; then
    print_message "Modo: Standalone (sin Traefik)"
    echo ""
    print_message "Sitio web: http://localhost:8080"
else
    print_message "Modo: Con Traefik (producción)"
    echo ""
    print_message "Dashboard de Traefik: http://traefik.cohortevidaypaz.com.co:8080"
    print_message "Sitio web: https://www.cohortevidaypaz.com.co"
fi
echo ""
