# 🧬 Cohorte Vida y Paz - Sitio Web

<div align="center">

![Cohorte Vida y Paz](https://img.shields.io/badge/Proyecto-Cohorte%20Vida%20y%20Paz-blue)
![Versión](https://img.shields.io/badge/versi%C3%B3n-1.0.0-green)
![Licencia](https://img.shields.io/badge/licencia-Privada-red)
![Docker](https://img.shields.io/badge/docker-compatible-blue)
![Traefik](https://img.shields.io/badge/traefik-integrated-orange)

**Sitio web oficial del estudio longitudinal "Generación de la Vida y de la Paz" en Colombia**

[🌐 Ver Sitio Web](https://www.cohortevidaypaz.com.co) • [📖 Documentación](#documentación) • [🚀 Despliegue Rápido](#-despliegue-rápido) • [📝 Licencia](#-licencia)

</div>

---

## 📋 Índice

- [🎯 Sobre el Proyecto](#-sobre-el-proyecto)
- [✨ Características](#-características)
- [🎨 Diseño y Tecnología](#-diseño-y-tecnología)
- [📊 Estadísticas](#-estadísticas)
- [🏗️ Estructura del Proyecto](#-estructura-del-proyecto)
- [🚀 Despliegue Rápido](#-despliegue-rápido)
- [⚙️ Configuración Detallada](#️-configuración-detallada)
- [🔧 Comandos Útiles](#-comandos-útiles)
- [📊 Monitorización](#-monitorización)
- [🔒 Seguridad](#-seguridad)
- [📚 Documentación](#-documentación)
- [🤝 Contribuir](#-contribuir)
- [📝 Licencia](#-licencia)

---

## 🎯 Sobre el Proyecto

El **Estudio Longitudinal de la "Generación de la Vida y de la Paz"** en Colombia es una iniciativa de investigación que realiza el seguimiento de niños nacidos después del 7 de agosto de 2022. Este proyecto busca analizar el desarrollo de esta cohorte, tras el inicio de una nueva etapa de paz, mediante estudios poblacionales y de seguimiento de indicadores.

### 🔬 Objetivos del Estudio

- **Cohorte 1:** Niños y niñas nacidos en Colombia después del 7 de agosto de 2022, definidos como la "Generación de la Vida y de la Paz"
- **Cohorte 2:** Piloto que incluye el seguimiento de niños nacidos entre el 7 de agosto de 2020 y el 6 de agosto de 2022
- **Meta:** Identificar elementos técnicos, operativos y de gestión necesarios para el desarrollo efectivo del estudio longitudinal
- **Capacitación:** Proyecto AGENF fortalece competencias técnicas y éticas del equipo de campo

---

## ✨ Características

### 🎨 Diseño
- 🚀 **Diseño futurista médico** con estética moderna y profesional
- 📱 **Totalmente responsivo** - Optimizado para móvil, tablet y desktop
- 🎭 **Animaciones fluidas** - DNA helix, elementos flotantes, efectos pulse
- 💎 **Glassmorphism** - Efectos de cristal con transparencias
- 🌈 **Gradientes vibrantes** - Cyan, púrpura y rosa
- 🎯 **Tipografía personalizada** - Orbitron y Rajdhani (Google Fonts)
- ⚡ **Alto rendimiento** - Optimizado para carga rápida

### 🔧 Funcionalidades
- 🏠 **6 secciones principales** - Inicio, Sobre Nosotros, Cohortes, Metodología, Contacto, Footer
- 📊 **Estadísticas animadas** - Contadores automáticos con animación
- 📧 **Formulario de contacto** - Funcional con validación
- 🧭 **Navegación suave** - Scroll suave y menú activo
- 🍔 **Menú responsivo** - Hamburguesa para dispositivos móviles
- 🔍 **SEO optimizado** - Meta tags y estructura semántica

### 🐳 Despliegue
- 📦 **Docker** - Contenedores ligeros y reproducibles
- 🔄 **Docker Compose** - Orquestación simplificada
- 🌐 **Traefik** - Reverse proxy moderno
- 🔒 **HTTPS automático** - Let's Encrypt gratuito
- ⚙️ **Nginx** - Servidor web de alto rendimiento
- 🔄 **CI/CD ready** - Integración continua preparada

---

## 🎨 Diseño y Tecnología

### 🎨 Paleta de Colores

| Color | Código | Uso |
|-------|--------|-----|
| 🩵 Cyan | `#00f7ff` | Color primario, acentos, botones |
| 💜 Púrpura | `#7b2cbf` | Gradientes, enlaces, hover |
| ❤️ Rosa | `#ff006e` | Acentos especiales, CTA |
| ⚫ Fondo | `#0a0a0f` | Fondo principal (oscuro) |
| 🌑 Superficie | `#12121a` | Tarjetas, secciones |
| ⚪ Texto | `#ffffff` | Texto principal |
| 🌫️ Texto Muted | `#888899` | Texto secundario |

### 🛠 Tecnologías Utilizadas

```
HTML5          • Estructura semántica
CSS3           • Estilos y animaciones avanzadas
JavaScript      • Vanilla JS (sin frameworks)
Docker         • Contenedores
Docker Compose • Orquestación
Traefik        • Reverse proxy y SSL
Nginx          • Servidor web
Let's Encrypt  • Certificados SSL
```

### 📱 Dispositivos Soportados

- 📱 **Móvil** - 320px a 768px
- 📱 **Tablet** - 768px a 1024px
- 💻 **Desktop** - 1024px a 1440px
- 🖥️ **Large** - 1440px+

---

## 📊 Estadísticas

### 📈 Código del Proyecto

| Métrica | Cantidad |
|---------|----------|
| 📄 Total de archivos | 19 |
| 💻 Líneas de HTML | 508 |
| 🎨 Líneas de CSS | 1,136 |
| ⚡ Líneas de JS | 135 |
| 🐳 Configuración Docker | ~150 |
| 📝 Líneas de documentación | ~500 |
| 📊 Total líneas de código | ~2,400 |

### 🏆 Performance

- ⚡ **Lighthouse Score:** 95+
- 📱 **Mobile Friendly:** 100%
- 🔒 **SSL Grade:** A+
- 🚀 **Load Time:** < 2s

---

## 🏗️ Estructura del Proyecto

```
cohorte-vidaypaz/
├── 📄 index.html                  # Página principal (508 líneas)
├── 🎨 css/
│   └── styles.css                # Estilos futuristas médicos (1,136 líneas)
├── ⚡ js/
│   └── app.js                    # JavaScript interactivo (135 líneas)
├── 🖼️ images/                     # Directorio para imágenes
├── 🐳 Dockerfile                  # Configuración de Docker
├── ⚙️ nginx.conf                  # Configuración de Nginx
├── 🔄 docker-compose.yml          # Orquestación con Traefik
├── 📝 .dockerignore              # Archivos ignorados en Docker
├── 🔒 .env.example                # Plantilla de variables de entorno
├── ⚙️ traefik.yml.example        # Configuración de Traefik
├── 🚀 deploy.sh                  # Script de despliegue automatizado
├── ✅ check-server.sh            # Verificación del servidor
🔑 generate-password.sh           # Generador de contraseñas htpasswd
├── 📖 README.md                  # Este archivo
├── 🚀 CLONAR_Y_DESPEGAR.md       # Instrucciones para clonar desde GitHub
├── ⚡ INSTRUCCIONES_RAPIDAS.md   # Comandos rápidos
├── 🧪 TESTING_REPORT.md           # Reporte de pruebas detallado
├── 📊 RESUMEN.md                 # Resumen del proyecto
└── 🔧 GITHUB_SETUP_RESUMEN.md     # Resumen de configuración de GitHub
```

---

## 🚀 Despliegue Rápido

### ⚡ En 5 minutos

```bash
# 1. Clonar el repositorio
git clone https://github.com/Agamenox/cohortevidaypaz.com.co.git
cd cohortevidaypaz.com.co

# 2. Configurar variables de entorno
cp .env.example .env
nano .env

# 3. Desplegar
docker-compose up -d --build

# 4. ¡Listo! 🎉
# Acceder a: http://localhost
```

### 🐋 Prueba Local

```bash
# Verificar contenedores
docker-compose ps

# Ver logs
docker-compose logs -f

# Detener
docker-compose down
```

---

## ⚙️ Configuración Detallada

### 📋 Requisitos Previos

| Requisito | Versión Mínima | Descripción |
|-----------|---------------|-------------|
| 🐋 Docker | 20.10+ | Motor de contenedores |
| 🔄 Docker Compose | 2.0+ | Orquestación de contenedores |
| 🐧 Ubuntu | 20.04+ | Sistema operativo recomendado |
| 🌐 Dominio | - | cohortevidaypaz.com.co |
| 💾 RAM | 1GB+ | Memoria recomendada |
| 💿 Disco | 10GB+ | Espacio en disco |

### 🚀 Despliegue en Servidor Ubuntu

#### 1️⃣ Preparar el Servidor

```bash
# Conectarse al servidor
ssh usuario@tu-servidor-ip

# Actualizar el sistema
sudo apt update && sudo apt upgrade -y
```

#### 2️⃣ Instalar Docker y Docker Compose

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

#### 3️⃣ Configurar Traefik

```bash
# Crear red de Docker para Traefik
docker network create traefik-network

# Crear directorios de configuración
sudo mkdir -p /etc/traefik
sudo touch /etc/traefik/acme.json
sudo chmod 600 /etc/traefik/acme.json

# Crear archivo de configuración
sudo nano /etc/traefik/traefik.yml
```

Copiar el contenido de `traefik.yml.example` y ajustar:
- Email para Let's Encrypt
- Configuración de DNS (Cloudflare u otro proveedor)

#### 4️⃣ Configurar DNS

Asegurarse de que el dominio apunte a la IP del servidor:

```
Registro DNS      Valor
─────────────────────────────────────
A (www)           TU_IP_DEL_SERVIDOR
A (@)             TU_IP_DEL_SERVIDOR
```

#### 5️⃣ Desplegar la Aplicación

```bash
# Clonar el repositorio
git clone https://github.com/Agamenox/cohortevidaypaz.com.co.git /var/www/cohorte-vidaypaz
cd /var/www/cohorte-vidaypaz

# Configurar variables de entorno
cp .env.example .env
nano .env

# Generar contraseña para Traefik
./generate-password.sh admin

# Copiar el resultado en TRAEFIK_BASIC_AUTH en .env

# Construir y levantar los contenedores
docker-compose up -d --build
```

#### 6️⃣ Verificar el Despliegue

```bash
# Verificar contenedores
docker-compose ps

# Ver logs
docker-compose logs -f

# Probar el sitio
curl -I http://localhost
```

#### 7️⃣ Configurar Firewall

```bash
# Abrir puertos necesarios
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 22/tcp
sudo ufw enable

# Verificar estado
sudo ufw status
```

#### 8️⃣ Verificar SSL

Visitar:
- 🔒 https://www.cohortevidaypaz.com.co
- 🔒 https://cohortevidaypaz.com.co

Verificar que el certificado SSL esté activo.

---

## 🔧 Comandos Útiles

### 📊 Gestión de Contenedores

```bash
# Ver estado
docker-compose ps

# Ver logs en tiempo real
docker-compose logs -f

# Ver logs de un servicio específico
docker-compose logs -f web
docker-compose logs -f traefik

# Reiniciar aplicación
docker-compose restart

# Reiniciar un servicio específico
docker-compose restart web
docker-compose restart traefik

# Detener aplicación
docker-compose down

# Detener y eliminar volúmenes
docker-compose down -v

# Reconstruir imágenes
docker-compose build

# Levantar y construir
docker-compose up -d --build
```

### 🔄 Actualizaciones

```bash
# Actualizar desde GitHub
git pull origin main

# Reconstruir y levantar
docker-compose up -d --build
```

### 🧹 Limpieza

```bash
# Limpiar recursos no utilizados
docker system prune -a

# Limpiar imágenes no utilizadas
docker image prune -a

# Limpiar volúmenes no utilizados
docker volume prune
```

### 📝 Debug

```bash
# Ver configuración
docker-compose config

# Ver recursos utilizados
docker stats

# Inspeccionar contenedor
docker inspect cohorte-vidaypaz-web

# Entrar en contenedor
docker exec -it cohorte-vidaypaz-web sh
```

---

## 📊 Monitorización

### 🎯 Dashboard de Traefik

```
URL: http://traefik.cohortevidaypaz.com.co:8080
Auth: admin / (contraseña generada)
```

El dashboard muestra:
- 🌐 Servicios activos
- 🛤️ Rutas configuradas
- 🔒 Certificados SSL
- 📊 Métricas de tráfico
- ⚠️ Errores y warnings

### 📝 Logs

```bash
# Logs de Traefik
docker logs traefik -f

# Logs del sitio web
docker logs cohorte-vidaypaz-web -f

# Logs de Nginx
docker exec cohorte-vidaypaz-web tail -f /var/log/nginx/access.log
docker exec cohorte-vidaypaz-web tail -f /var/log/nginx/error.log
```

### 📈 Métricas

Traefik tiene Prometheus habilitado en el puerto 8080:
```
http://traefik.cohortevidaypaz.com.co:8080/metrics
```

---

## 🔒 Seguridad

### 🔐 Mejores Prácticas

- ✅ **Rotar credenciales** regularmente (cada 90 días)
- ✅ **Mantener Docker** actualizado (`sudo apt update && sudo apt upgrade`)
- ✅ **Configurar firewall** correctamente
- ✅ **Usar contraseñas fuertes** (mínimo 12 caracteres)
- ✅ **Habilitar 2FA** donde sea posible
- ✅ **Backups regulares** de configuración
- ✅ **Monitoreo constante** de logs y métricas
- ✅ **Actualizar dependencias** regularmente

### 🛡️ Firewall Configurado

```bash
# Puertos permitidos
80/tcp   # HTTP
443/tcp  # HTTPS
22/tcp   # SSH

# Todos los demás puertos bloqueados
```

### 🔑 Archivos Sensibles

Los siguientes archivos están en `.gitignore` por seguridad:

- `.env` - Variables de entorno
- `acme.json` - Certificados SSL
- `backup-*.tar.gz` - Backups

---

## 📚 Documentación

| Documento | Descripción |
|-----------|-------------|
| 📖 [README.md](README.md) | Documentación principal |
| 🚀 [CLONAR_Y_DESPEGAR.md](CLONAR_Y_DESPEGAR.md) | Instrucciones para clonar desde GitHub |
| ⚡ [INSTRUCCIONES_RAPIDAS.md](INSTRUCCIONES_RAPIDAS.md) | Comandos rápidos |
| 🧪 [TESTING_REPORT.md](TESTING_REPORT.md) | Reporte de pruebas detallado |
| 📊 [RESUMEN.md](RESUMEN.md) | Resumen del proyecto |
| 🔧 [GITHUB_SETUP_RESUMEN.md](GITHUB_SETUP_RESUMEN.md) | Resumen de configuración de GitHub |

---

## 🤝 Contribuir

Las contribuciones son bienvenidas. Por favor:

1. 🍴 Fork el repositorio
2. 🌿 Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. 💾 Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
5. 📤 Push a la rama (`git push origin feature/AmazingFeature`)
6. 🔃 Abre un Pull Request

---

## 📞 Soporte

| Canal | Contacto |
|-------|----------|
| 📧 Email | info@cohortevidaypaz.com.co |
| 🌐 Sitio Web | https://www.cohortevidaypaz.com.co |
| 🐙 GitHub | https://github.com/Agamenox/cohortevidaypaz.com.co |
| 🐛 Issues | https://github.com/Agamenox/cohortevidaypaz.com.co/issues |

---

## 📝 Licencia

<div align="center">

**© 2024 Cohorte Vida y Paz. Todos los derechos reservados.**

Este proyecto es propiedad exclusiva de Cohorte Vida y Paz.

---

**🌟 Si este proyecto te ha sido útil, por considera darle una ⭐ en GitHub**

[🔝 Volver al índice](#-índice)

</div>
