# 📥 Instrucciones para Clonar y Desplegar desde GitHub

## En Servidor Ubuntu

### 1️⃣ Clonar el Repositorio

```bash
# Ir al directorio donde quieres desplegar
cd /var/www/

# Clonar el repositorio
git clone https://github.com/Agamenox/cohortevidaypaz.com.co.git
```

### 2️⃣ Configurar el Proyecto

```bash
# Entrar al directorio del proyecto
cd /var/www/cohortevidaypaz.com.co

# Verificar servidor
./check-server.sh
```

### 3️⃣ Configurar Variables de Entorno

```bash
# Copiar ejemplo de variables de entorno
cp .env.example .env

# Editar configuración
nano .env
```

Generar contraseña para Traefik:

```bash
./generate-password.sh admin
```

Copiar el resultado en `TRAEFIK_BASIC_AUTH` en `.env`.

### 4️⃣ Configurar Traefik (PRIMERA VEZ)

```bash
# Crear directorio de configuración
sudo mkdir -p /etc/traefik

# Crear archivo para certificados SSL
sudo touch /etc/traefik/acme.json
sudo chmod 600 /etc/traefik/acme.json

# Crear red de Docker para Traefik
docker network create traefik-network

# Copiar configuración de ejemplo
sudo cp traefik.yml.example /etc/traefik/traefik.yml

# Editar configuración de Traefik
sudo nano /etc/traefik/traefik.yml
```

**Editar en `/etc/traefik/traefik.yml`:**
- Cambiar el email de Let's Encrypt
- Configurar proveedor de DNS (Cloudflare, etc.)

### 5️⃣ Configurar DNS

Asegúrate de que estos registros DNS apunten a tu IP del servidor:
- `cohortevidaypaz.com.co` → TU_IP
- `www.cohortevidaypaz.com.co` → TU_IP

### 6️⃣ Configurar Firewall

```bash
# Permitir puertos necesarios
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 22/tcp
sudo ufw enable
```

### 7️⃣ Desplegar

```bash
# Ejecutar script de despliegue
./deploy.sh
```

### 8️⃣ Verificar Despliegue

```bash
# Ver estado de contenedores
docker-compose ps

# Ver logs
docker-compose logs -f
```

### 9️⃣ Probar el Sitio Web

Visitar:
- https://www.cohortevidaypaz.com.co
- https://cohortevidaypaz.com.co

Verificar que el certificado SSL esté activo.

## 🔧 Comandos Útiles

### Actualizar el Proyecto desde GitHub

```bash
# Ir al directorio del proyecto
cd /var/www/cohortevidaypaz.com.co

# Actualizar desde GitHub
git pull origin main

# Reconstruir y levantar contenedores
docker-compose up -d --build
```

### Ver Estado de Contenedores

```bash
docker-compose ps
```

### Ver Logs

```bash
# Ver todos los logs
docker-compose logs -f

# Ver logs de un servicio específico
docker-compose logs -f web
docker-compose logs -f traefik
```

### Reiniciar Servicios

```bash
# Reiniciar todos
docker-compose restart

# Reiniciar un servicio específico
docker-compose restart web
docker-compose restart traefik
```

### Detener Servicios

```bash
docker-compose down
```

### Ver Uso de Recursos

```bash
docker stats
```

## 🌐 URLs de Producción

- **Sitio Web:** https://www.cohortevidaypaz.com.co
- **Sin www:** https://cohortevidaypaz.com.co
- **Dashboard Traefik:** http://traefik.cohortevidaypaz.com.co:8080

## 📊 Monitoreo

### Ver Métricas de Traefik

El dashboard de Traefik muestra:
- Servicios activos
- Rutas configuradas
- Certificados SSL
- Métricas de tráfico

### Logs del Sistema

```bash
# Logs de Nginx
docker logs cohortevidaypaz-web -f

# Logs de Traefik
docker logs traefik -f
```

## 🔄 Flujo de Trabajo para Actualizaciones

1. **Hacer cambios localmente**
2. **Commit y push a GitHub**
3. **En el servidor:**
   ```bash
   cd /var/www/cohortevidaypaz.com.co
   git pull origin main
   docker-compose up -d --build
   ```

## 🆘 Solución de Problemas

### Contenedores no inician

```bash
# Ver logs de errores
docker-compose logs

# Verificar configuración
docker-compose config
```

### Certificados SSL no se generan

```bash
# Verificar archivo acme.json
ls -la /etc/traefik/acme.json

# Ver logs de Traefik
docker logs traefik -f
```

### Sitio web no es accesible

```bash
# Verificar contenedores
docker-compose ps

# Verificar puertos
netstat -tuln | grep -E ':(80|443)'

# Verificar firewall
sudo ufw status
```

## 📚 Documentación Adicional

- `README.md` - Documentación completa
- `INSTRUCCIONES_RAPIDAS.md` - Instrucciones rápidas
- `TESTING_REPORT.md` - Reporte de pruebas
- `RESUMEN.md` - Resumen del proyecto

## 📞 Soporte

Para problemas o preguntas:
- Email: info@cohortevidaypaz.com.co
- Sitio web: https://www.cohortevidaypaz.com.co

---

**Repositorio GitHub:** https://github.com/Agamenox/cohortevidaypaz.com.co.git

© 2024 Cohorte Vida y Paz. Todos los derechos reservados.
