# 🚀 Instrucciones Rápidas de Despliegue

## Para Servidor Ubuntu

### 1️⃣ Subir archivos al servidor
```bash
scp -r cohorte-vidaypaz/ usuario@tu-servidor-ip:/var/www/
```

### 2️⃣ Conectarse al servidor
```bash
ssh usuario@tu-servidor-ip
cd /var/www/cohorte-vidaypaz
```

### 3️⃣ Verificar servidor
```bash
./check-server.sh
```

### 4️⃣ Configurar variables de entorno
```bash
cp .env.example .env
nano .env
```

Generar contraseña:
```bash
./generate-password.sh admin
```
Copiar el resultado en `TRAEFIK_BASIC_AUTH` en `.env`.

### 5️⃣ Configurar Traefik (PRIMERA VEZ SOLAMENTE)
```bash
sudo mkdir -p /etc/traefik
sudo touch /etc/traefik/acme.json
sudo chmod 600 /etc/traefik/acme.json
docker network create traefik-network
```

Copiar `traefik.yml.example` a `/etc/traefik/traefik.yml`:
```bash
sudo cp traefik.yml.example /etc/traefik/traefik.yml
sudo nano /etc/traefik/traefik.yml
```

### 6️⃣ Configurar DNS
Asegúrate de que estos registros apunten a tu IP del servidor:
- `cohortevidaypaz.com.co` → TU_IP
- `www.cohortevidaypaz.com.co` → TU_IP

### 7️⃣ Desplegar
```bash
./deploy.sh
```

### 8️⃣ Verificar
```bash
docker-compose ps
docker-compose logs -f
```

## 🔧 Comandos Útiles

### Ver estado
```bash
docker-compose ps
```

### Ver logs
```bash
docker-compose logs -f
```

### Reiniciar
```bash
docker-compose restart
```

### Detener
```bash
docker-compose down
```

### Actualizar
```bash
git pull
docker-compose up -d --build
```

## 🌐 URLs

- **Sitio Web:** https://www.cohortevidaypaz.com.co
- **Dashboard Traefik:** http://traefik.cohortevidaypaz.com.co:8080

## ⚠️ Requisitos

- Docker y Docker Compose instalados
- Dominio configurado con DNS
- Puertos 80, 443 abiertos en firewall

## 📚 Documentación Completa

Ver `README.md` para documentación detallada.
