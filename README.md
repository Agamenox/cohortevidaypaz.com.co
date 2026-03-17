# Cohorte Vida y Paz - Sitio Web

Sitio web oficial del estudio longitudinal "Generación de la Vida y de la Paz" en Colombia.

## Características

- Diseño futurista médico con animaciones fluidas
- Responsivo y optimizado para todos los dispositivos
- Desplegado con Docker y Traefik
- HTTPS automático con Let's Encrypt
- Alto rendimiento con Nginx

## Requisitos Previos

- Docker y Docker Compose instalados
- Servidor Ubuntu con acceso SSH
- Dominio configurado: cohortevidaypaz.com.co
- Traefik configurado en el servidor

## Estructura del Proyecto

```
cohorte-vidaypaz/
├── index.html          # Página principal
├── css/
│   └── styles.css      # Estilos CSS
├── js/
│   └── app.js          # JavaScript
├── images/             # Imágenes y assets
├── Dockerfile          # Configuración de Docker
├── nginx.conf          # Configuración de Nginx
├── docker-compose.yml  # Orquestación con Traefik
├── .env.example        # Variables de entorno de ejemplo
└── traefik.yml.example # Configuración de Traefik de ejemplo
```

## Despliegue en Servidor Ubuntu

### 1. Preparar el Servidor

Conectarse al servidor Ubuntu:

```bash
ssh usuario@tu-servidor-ip
```

Actualizar el sistema:

```bash
sudo apt update && sudo apt upgrade -y
```

### 2. Instalar Docker y Docker Compose

```bash
# Instalar Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Agregar usuario al grupo docker
sudo usermod -aG docker $USER

# Instalar Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Verificar instalación
docker --version
docker-compose --version
```

### 3. Configurar Traefik

Crear red de Docker para Traefik:

```bash
docker network create traefik-network
```

Crear directorios de configuración:

```bash
sudo mkdir -p /etc/traefik
sudo touch /etc/traefik/acme.json
sudo chmod 600 /etc/traefik/acme.json
```

Crear archivo de configuración de Traefik:

```bash
sudo nano /etc/traefik/traefik.yml
```

Copiar el contenido de `traefik.yml.example` y ajustar:

- Email para Let's Encrypt
- Configuración de DNS (Cloudflare u otro proveedor)

### 4. Configurar DNS

Asegurarse de que el dominio apunte a la IP del servidor:

```
A    www.cohortevidaypaz.com.co    ->    TU_IP_DEL_SERVIDOR
A    cohortevidaypaz.com.co        ->    TU_IP_DEL_SERVIDOR
```

### 5. Desplegar la Aplicación

Subir los archivos al servidor:

```bash
# En tu máquina local
scp -r cohorte-vidaypaz/ usuario@tu-servidor-ip:/path/deploy/
```

O clonar desde repositorio:

```bash
git clone tu-repositorio /path/deploy/cohorte-vidaypaz
cd /path/deploy/cohorte-vidaypaz
```

Configurar variables de entorno:

```bash
cp .env.example .env
nano .env
```

Generar contraseña para Traefik:

```bash
# Instalar htpasswd si no está instalado
sudo apt install apache2-utils -y

# Generar contraseña
htpasswd -nb admin tu_contraseña_segura
```

Copiar el resultado en la variable `TRAEFIK_BASIC_AUTH` en `.env`.

Construir y levantar los contenedores:

```bash
docker-compose up -d --build
```

### 6. Verificar el Despliegue

Verificar que los contenedores estén corriendo:

```bash
docker-compose ps
```

Verificar logs:

```bash
docker-compose logs -f
```

Probar el sitio web:

```bash
curl -I http://localhost
```

### 7. Configurar Firewall

Abrir puertos necesarios:

```bash
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 22/tcp
sudo ufw enable
```

### 8. Verificar SSL

Visitar:
- https://www.cohortevidaypaz.com.co
- https://cohortevidaypaz.com.co

Verificar que el certificado SSL esté activo.

## Comandos Útiles

### Ver estado de los contenedores:
```bash
docker-compose ps
```

### Ver logs en tiempo real:
```bash
docker-compose logs -f
```

### Reiniciar la aplicación:
```bash
docker-compose restart
```

### Detener la aplicación:
```bash
docker-compose down
```

### Actualizar la aplicación:
```bash
git pull
docker-compose up -d --build
```

### Limpiar recursos no utilizados:
```bash
docker system prune -a
```

## Monitorización

### Dashboard de Traefik:
http://traefik.cohortevidaypaz.com.co:8080

### Logs de Traefik:
```bash
docker logs traefik -f
```

### Logs del sitio web:
```bash
docker logs cohorte-vidaypaz-web -f
```

## Backup

### Backup de la configuración:
```bash
tar -czf backup-$(date +%Y%m%d).tar.gz /etc/traefik
```

### Backup de los contenedores:
```bash
docker-compose config > backup-compose.yml
```

## Seguridad

- Rotar credenciales regularmente
- Mantener Docker y Traefik actualizados
- Configurar firewall correctamente
- Usar contraseñas fuertes
- Habilitar autenticación de dos factores donde sea posible

## Soporte

Para issues o preguntas:
- Email: info@cohortevidaypaz.com.co
- Sitio web: https://www.cohortevidaypaz.com.co

## Licencia

© 2024 Cohorte Vida y Paz. Todos los derechos reservados.
