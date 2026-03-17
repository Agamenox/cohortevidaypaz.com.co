#!/bin/bash

# Script de verificación previa al despliegue
# Para usar en servidor Ubuntu

set -e

echo "=========================================="
echo "Verificación Previa al Despliegue"
echo "=========================================="
echo ""

# Colores
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

PASS=0
FAIL=0

check_pass() {
    echo -e "${GREEN}✓${NC} $1"
    ((PASS++))
}

check_fail() {
    echo -e "${RED}✗${NC} $1"
    ((FAIL++))
}

check_warn() {
    echo -e "${YELLOW}⚠${NC} $1"
}

echo "Verificando sistema..."
echo ""

# Verificar sistema operativo
if [ -f /etc/os-release ]; then
    . /etc/os-release
    echo "Sistema: $PRETTY_NAME"
    if [[ "$ID" == "ubuntu" ]]; then
        check_pass "Sistema operativo: Ubuntu"
    else
        check_warn "Sistema operativo: $ID (se recomienda Ubuntu)"
    fi
else
    check_fail "No se pudo detectar el sistema operativo"
fi

# Verificar memoria
TOTAL_MEM=$(free -m | awk '/^Mem:/{print $2}')
if [ $TOTAL_MEM -ge 1024 ]; then
    check_pass "Memoria: ${TOTAL_MEM}MB"
else
    check_warn "Memoria baja: ${TOTAL_MEM}MB (se recomienda mínimo 1GB)"
fi

# Verificar espacio en disco
DISK_SPACE=$(df -BG / | awk 'NR==2 {print $4}' | sed 's/G//')
if [ $DISK_SPACE -ge 10 ]; then
    check_pass "Espacio en disco: ${DISK_SPACE}GB"
else
    check_warn "Espacio en disco bajo: ${DISK_SPACE}GB (se recomienda mínimo 10GB)"
fi

echo ""
echo "Verificando dependencias..."
echo ""

# Verificar Docker
if command -v docker &> /dev/null; then
    DOCKER_VERSION=$(docker --version | awk '{print $3}' | sed 's/,//')
    check_pass "Docker instalado: $DOCKER_VERSION"
else
    check_fail "Docker no está instalado"
fi

# Verificar Docker Compose
if command -v docker-compose &> /dev/null; then
    COMPOSE_VERSION=$(docker-compose --version | awk '{print $4}' | sed 's/,//')
    check_pass "Docker Compose instalado: $COMPOSE_VERSION"
else
    check_fail "Docker Compose no está instalado"
fi

# Verificar Git
if command -v git &> /dev/null; then
    GIT_VERSION=$(git --version | awk '{print $3}')
    check_pass "Git instalado: $GIT_VERSION"
else
    check_warn "Git no está instalado (opcional para clonar repositorio)"
fi

# Verificar htpasswd
if command -v htpasswd &> /dev/null; then
    check_pass "htpasswd instalado"
else
    check_warn "htpasswd no está instalado (necesario para generar passwords)"
fi

echo ""
echo "Verificando red..."
echo ""

# Verificar puerto 80
if ! netstat -tuln | grep -q ":80 "; then
    check_pass "Puerto 80 disponible"
else
    check_warn "Puerto 80 en uso"
fi

# Verificar puerto 443
if ! netstat -tuln | grep -q ":443 "; then
    check_pass "Puerto 443 disponible"
else
    check_warn "Puerto 443 en uso"
fi

# Verificar puerto 8080
if ! netstat -tuln | grep -q ":8080 "; then
    check_pass "Puerto 8080 disponible"
else
    check_warn "Puerto 8080 en uso"
fi

echo ""
echo "Verificando configuración de Traefik..."
echo ""

# Verificar archivo de configuración
if [ -f /etc/traefik/traefik.yml ]; then
    check_pass "Archivo de configuración de Traefik encontrado"
else
    check_fail "Archivo /etc/traefik/traefik.yml no encontrado"
fi

# Verificar red de Traefik
if docker network inspect traefik-network &> /dev/null; then
    check_pass "Red traefik-network existe"
else
    check_warn "Red traefik-network no existe (se creará durante el despliegue)"
fi

# Verificar archivo ACME
if [ -f /etc/traefik/acme.json ]; then
    check_pass "Archivo acme.json encontrado"
    PERMISSIONS=$(stat -c %a /etc/traefik/acme.json)
    if [ "$PERMISSIONS" = "600" ]; then
        check_pass "Permisos correctos en acme.json"
    else
        check_warn "Permisos incorrectos en acme.json (debería ser 600)"
    fi
else
    check_fail "Archivo /etc/traefik/acme.json no encontrado"
fi

echo ""
echo "Verificando dominio..."
echo ""

# Verificar DNS del dominio
DOMAIN="cohortevidaypaz.com.co"
if command -v dig &> /dev/null; then
    DNS_IP=$(dig +short $DOMAIN)
    SERVER_IP=$(curl -s ifconfig.me)
    if [ "$DNS_IP" = "$SERVER_IP" ]; then
        check_pass "DNS de $DOMAIN apunta a este servidor ($SERVER_IP)"
    else
        check_warn "DNS de $DOMAIN apunta a $DNS_IP, servidor IP es $SERVER_IP"
    fi
    
    DNS_WWW=$(dig +short www.$DOMAIN)
    if [ "$DNS_WWW" = "$SERVER_IP" ]; then
        check_pass "DNS de www.$DOMAIN apunta a este servidor ($SERVER_IP)"
    else
        check_warn "DNS de www.$DOMAIN apunta a $DNS_WWW, servidor IP es $SERVER_IP"
    fi
else
    check_warn "No se pudo verificar DNS (comando dig no disponible)"
fi

echo ""
echo "Verificando archivos del proyecto..."
echo ""

# Verificar archivos necesarios
FILES=("index.html" "css/styles.css" "js/app.js" "Dockerfile" "nginx.conf" "docker-compose.yml")
for file in "${FILES[@]}"; do
    if [ -f "$file" ]; then
        check_pass "Archivo $file encontrado"
    else
        check_fail "Archivo $file no encontrado"
    fi
done

# Verificar directorios
DIRS=("css" "js" "images")
for dir in "${DIRS[@]}"; do
    if [ -d "$dir" ]; then
        check_pass "Directorio $dir encontrado"
    else
        check_fail "Directorio $dir no encontrado"
    fi
done

# Verificar archivo .env
if [ -f ".env" ]; then
    check_pass "Archivo .env encontrado"
else
    check_warn "Archivo .env no encontrado (se creará desde .env.example)"
fi

echo ""
echo "=========================================="
echo "Resumen"
echo "=========================================="
echo -e "${GREEN}Pasados: $PASS${NC}"
echo -e "${RED}Fallidos: $FAIL${NC}"
echo ""

if [ $FAIL -eq 0 ]; then
    echo -e "${GREEN}✓ Todas las verificaciones críticas pasaron${NC}"
    echo "Puedes proceder con el despliegue usando: ./deploy.sh"
    exit 0
else
    echo -e "${RED}✗ Hay verificaciones fallidas que deben corregirse${NC}"
    echo "Por favor, corrige los errores antes de continuar"
    exit 1
fi
