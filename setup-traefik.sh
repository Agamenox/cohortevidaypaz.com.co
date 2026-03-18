#!/bin/bash

# Script de configuración automática de Traefik para Cohorte Vida y Paz
# Para usar en servidor Ubuntu

set -e

echo "=========================================="
echo "Configuración de Traefik"
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
if [ "$EUID" -ne 0 ]; then 
    print_error "Este script debe ejecutarse como root"
    echo "Usa: sudo ./setup-traefik.sh"
    exit 1
fi

# Verificar Docker
print_message "Verificando Docker..."
if ! command -v docker &> /dev/null; then
    print_error "Docker no está instalado"
    exit 1
fi

# Crear directorio de configuración
print_message "Creando directorio de configuración..."
mkdir -p /etc/traefik

# Crear archivo acme.json
print_message "Creando archivo acme.json..."
touch /etc/traefik/acme.json
chmod 600 /etc/traefik/acme.json

# Crear archivo de configuración de Traefik
print_message "Creando archivo de configuración de Traefik..."
cat > /etc/traefik/traefik.yml <<'EOF'
# Traefik Configuration File
# Generado automáticamente por setup-traefik.sh

global:
  checkNewVersion: true
  sendAnonymousUsage: false

api:
  dashboard: true
  insecure: false

entryPoints:
  web:
    address: ":80"
    http:
      redirections:
        entryPoint:
          to: websecure
          scheme: https
          permanent: true
  
  websecure:
    address: ":443"
    http:
      tls:
        certResolver: letsencrypt

providers:
  docker:
    endpoint: "unix:///var/run/docker.sock"
    exposedByDefault: false
    network: traefik-network

certificatesResolvers:
  letsencrypt:
    acme:
      email: admin@cohortevidaypaz.com.co
      storage: /acme.json
      httpChallenge:
        entryPoint: web

log:
  level: INFO
  filePath: /var/log/traefik/traefik.log
  format: json

accessLog:
  filePath: /var/log/traefik/access.log
  format: json

ping:
  entryPoint: web
EOF

# Crear directorio de logs
print_message "Creando directorio de logs..."
mkdir -p /var/log/traefik

# Crear red de Traefik
print_message "Verificando red de Traefik..."
if ! docker network inspect traefik-network &> /dev/null; then
    print_message "Creando red traefik-network..."
    docker network create traefik-network
else
    print_message "Red traefik-network ya existe"
fi

echo ""
print_message "=========================================="
print_message "Configuración de Traefik completada"
print_message "=========================================="
echo ""
print_message "Archivos creados:"
print_message "  - /etc/traefik/traefik.yml (configuración)"
print_message "  - /etc/traefik/acme.json (certificados SSL)"
print_message "  - /var/log/traefik (logs)"
echo ""
print_message "Configuración predeterminada:"
print_message "  - Email: admin@cohortevidaypaz.com.co"
print_message "  - Dashboard: http://traefik.cohortevidaypaz.com.co:8080"
print_message "  - Red: traefik-network"
echo ""
print_warning "IMPORTANTE:"
print_warning "  1. Editar /etc/traefik/traefik.yml para cambiar el email"
print_warning "  2. Configurar el proveedor de DNS (Cloudflare, etc.)"
print_warning "  3. Asegurarse de que el dominio apunte a este servidor"
echo ""
print_message "Para editar la configuración:"
echo "  sudo nano /etc/traefik/traefik.yml"
echo ""
print_message "Para iniciar Traefik manualmente:"
echo "  docker run -d \\"
echo "    --name traefik \\"
echo "    --network traefik-network \\"
echo "    -p 80:80 -p 443:443 -p 8080:8080 \\"
echo "    -v /var/run/docker.sock:/var/run/docker.sock \\"
echo "    -v /etc/traefik/acme.json:/acme.json \\"
echo "    -v /etc/traefik/traefik.yml:/etc/traefik/traefik.yml \\"
echo "    traefik:v3.0"
echo ""
