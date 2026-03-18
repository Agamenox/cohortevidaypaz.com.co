# 🚀 Guía de Despliegue Rápido - Opciones

## 📅 Fecha: 17 de Marzo de 2026

---

## 🎯 Opciones de Despliegue

El script `deploy.sh` ahora ofrece **3 opciones** de despliegue:

### 1️⃣ Despliegue con Traefik (Producción)

Recomendado para servidores en producción con dominio configurado.

**Características:**
- ✅ HTTPS automático con Let's Encrypt
- ✅ Reverse proxy moderno
- ✅ Dashboard de Traefik
- ✅ Certificados SSL gratuitos
- ✅ Configuración automática

**Requisitos:**
- Dominio configurado con DNS
- Puertos 80, 443 abiertos
- Configuración de Traefik

**Cómo usar:**
```bash
./deploy.sh
# Seleccionar: 1
```

---

### 2️⃣ Despliegue Standalone (Pruebas Locales)

Ideal para pruebas locales o desarrollo sin dominio.

**Características:**
- ✅ Sin configurar Traefik
- ✅ Solo servidor web (Nginx)
- ✅ Puerto 8080 local
- ✅ Rápido y simple

**Requisitos:**
- Solo Docker y Docker Compose
- Sin necesidad de dominio
- Sin necesidad de Traefik

**Cómo usar:**
```bash
./deploy.sh
# Seleccionar: 2
```

**Sitio web:** http://localhost:8080

---

### 3️⃣ Configuración Automática de Traefik

Si no tienes Traefik configurado, el script puede configurarlo automáticamente.

**Cómo funciona:**
1. Ejecuta `setup-traefik.sh`
2. Crea archivos de configuración automáticamente
3. Crea red de Traefik
4. Prepara todo para producción

**Cómo usar:**
```bash
./deploy.sh
# Seleccionar: 1
# Responder: y (configurar automáticamente)
```

---

## 📋 Comparación de Opciones

| Opción | Traefik | HTTPS | DNS | Uso |
|---------|-----------|--------|------|------|
| 1. Con Traefik | ✅ Sí | ✅ Sí | Producción |
| 2. Standalone | ❌ No | ❌ No | Desarrollo/Pruebas |
| 3. Auto-config | ✅ Sí | ✅ Sí | Producción |

---

## 🔧 Configuración Manual de Traefik

Si prefieres configurar Traefik manualmente:

### Paso 1: Crear directorios
```bash
sudo mkdir -p /etc/traefik
sudo touch /etc/traefik/acme.json
sudo chmod 600 /etc/traefik/acme.json
```

### Paso 2: Crear archivo de configuración
```bash
sudo nano /etc/traefik/traefik.yml
```

Contenido básico:
```yaml
global:
  checkNewVersion: true
  sendAnonymousUsage: false

api:
  dashboard: true
  insecure: false

entryPoints:
  web:
    address: ":80"
  websecure:
    address: ":443"

providers:
  docker:
    endpoint: "unix:///var/run/docker.sock"
    exposedByDefault: false

certificatesResolvers:
  letsencrypt:
    acme:
      email: admin@cohortevidaypaz.com.co
      storage: /acme.json
      httpChallenge:
        entryPoint: web
```

### Paso 3: Crear red
```bash
docker network create traefik-network
```

---

## 🚀 Comandos de Despliegue

### Despliegue con Traefik
```bash
# Actualizar desde GitHub
git pull origin main

# Ejecutar despliegue
./deploy.sh
# Seleccionar: 1
```

### Despliegue Standalone
```bash
# Actualizar desde GitHub
git pull origin main

# Ejecutar despliegue
./deploy.sh
# Seleccionar: 2
```

### Configuración Automática de Traefik
```bash
# Actualizar desde GitHub
git pull origin main

# Ejecutar script de configuración
sudo ./setup-traefik.sh

# Ejecutar despliegue
./deploy.sh
# Seleccionar: 1 (ya configurado)
```

---

## 📊 Uso de Recursos

### Modo Con Traefik
- **Contenedores:** 2 (Traefik + Web)
- **Puertos:** 80, 443, 8080
- **Redes:** traefik-network
- **RAM:** ~100MB

### Modo Standalone
- **Contenedores:** 1 (Web)
- **Puertos:** 8080
- **Redes:** cohorte-vidaypaz-network
- **RAM:** ~50MB

---

## 🔍 Verificación de Despliegue

### Despliegue con Traefik
```bash
# Ver contenedores
docker compose ps

# Ver logs de Traefik
docker logs traefik -f

# Ver logs del sitio web
docker logs cohorte-vidaypaz-web -f

# Acceder al dashboard
http://traefik.cohortevidaypaz.com.co:8080

# Acceder al sitio web
https://www.cohortevidaypaz.com.co
```

### Despliegue Standalone
```bash
# Ver contenedores
docker compose -f docker-compose.standalone.yml ps

# Ver logs
docker compose -f docker-compose.standalone.yml logs -f

# Acceder al sitio web
http://localhost:8080
```

---

## ⚠️ Notas Importantes

### Para Producción
- Usa la opción 1 (con Traefik)
- Configura el DNS del dominio
- Abre puertos 80 y 443
- Usa HTTPS obligatoriamente

### Para Desarrollo
- Usa la opción 2 (standalone)
- Más rápido y simple
- No requiere dominio
- Solo para pruebas locales

### Certificados SSL
- Traefik genera certificados automáticamente
- Los certificados se guardan en `/etc/traefik/acme.json`
- Demora ~5 minutos en generarse

---

## 📞 Soporte

Para problemas o preguntas:
- Email: info@cohortevidaypaz.com.co
- Sitio web: https://www.cohortevidaypaz.com.co
- GitHub: https://github.com/Agamenox/cohortevidaypaz.com.co/issues

---

## ✨ Conclusión

El script `deploy.sh` ahora ofrece múltiples opciones de despliegue adaptadas a tus necesidades:

- **Opción 1:** Producción con Traefik y HTTPS
- **Opción 2:** Desarrollo rápido sin Traefik
- **Opción 3:** Configuración automática de Traefik

Selecciona la opción que mejor se adapte a tu caso de uso.

---

*Actualizado el 17 de Marzo de 2026*
*© 2024 Cohorte Vida y Paz. Todos los derechos reservados.*
