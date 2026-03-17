#!/bin/bash

# Script para generar contraseñas htpasswd para Traefik
# Para usar en servidor Ubuntu

if [ -z "$1" ]; then
    echo "Uso: $0 <usuario> [contraseña]"
    echo ""
    echo "Ejemplos:"
    echo "  $0 admin                    # Solicita contraseña interactivamente"
    echo "  $0 admin mi_contraseña     # Usa la contraseña proporcionada"
    exit 1
fi

USERNAME="$1"

if [ -z "$2" ]; then
    # Solicitar contraseña de forma segura
    read -s -p "Contraseña para $USERNAME: " PASSWORD
    echo
    read -s -p "Confirmar contraseña: " PASSWORD_CONFIRM
    echo
    
    if [ "$PASSWORD" != "$PASSWORD_CONFIRM" ]; then
        echo "Error: Las contraseñas no coinciden"
        exit 1
    fi
else
    PASSWORD="$2"
fi

# Generar hash htpasswd
if command -v htpasswd &> /dev/null; then
    HASH=$(htpasswd -nb "$USERNAME" "$PASSWORD" | sed -e 's/\\$/\\$\\$/g')
    echo ""
    echo "Hash generado:"
    echo "$HASH"
    echo ""
    echo "Copia este valor en la variable TRAEFIK_BASIC_AUTH en tu archivo .env:"
    echo "TRAEFIK_BASIC_AUTH=$HASH"
    echo ""
else
    echo "Error: htpasswd no está instalado"
    echo "Instálalo con: sudo apt install apache2-utils"
    exit 1
fi
