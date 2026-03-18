# ⚡ Solución Rápida - Despliegue sin Traefik

## 📅 Fecha: 17 de Marzo de 2026

---

## ✅ Problema Solucionado

Al ejecutar `./deploy.sh`, el script detecta que no existe la configuración de Traefik y te pregunta qué hacer.

---

## 🚀 3 Opciones de Despliegue

Ahora el script `deploy.sh` te ofrece **3 opciones**:

### OPCIÓN 1: Configurar Traefik Automáticamente

```bash
./deploy.sh
# Seleccionar: 1
# Responder: y
```

✅ Crea toda la configuración automáticamente
✅ Configura Traefik
✅ Prepara para producción

### OPCIÓN 2: Modo Standalone (RECOMENDADO PARA PRUEBAS)

```bash
./deploy.sh
# Seleccionar: 2
```

✅ Sin Traefik
✅ Más rápido
✅ Solo para pruebas locales
✅ Sitio web en: http://localhost:8080

### OPCIÓN 3: Cancelar

```bash
./deploy.sh
# Seleccionar: 3
```

❌ Cancela el despliegue

---

## 🎯 ¿Cuál opción usar?

### PARA PRUEBAS LOCALES → OPCIÓN 2

```bash
cd /home/admin/site/cohortevidaypaz.com.co
git pull origin main
./deploy.sh
# Seleccionar: 2
```

**Ventajas:**
- ❌ No necesitas configurar Traefik
- ❌ No necesitas dominio
- ❌ No necesitas certificados SSL
- ✅ Más rápido y simple
- ✅ Funciona inmediatamente

### PARA PRODUCCIÓN → OPCIÓN 1 o CONFIGURACIÓN MANUAL

```bash
cd /home/admin/site/cohortevidaypaz.com.co
git pull origin main

# Opción A: Configuración automática
sudo ./setup-traefik.sh
./deploy.sh
# Seleccionar: 1 (ya configurado)

# Opción B: Configuración manual
# (Ver GUIA_DESPLEGUE_OPCIONES.md)
```

**Ventajas:**
- ✅ HTTPS automático
- ✅ Certificados SSL gratis
- ✅ Dashboard de Traefik
- ✅ Reverse proxy moderno

---

## 📋 Resumen de Archivos Nuevos

### Scripts
- **setup-traefik.sh** - Configura Traefik automáticamente
- **deploy.sh** - Actualizado con 3 opciones de despliegue

### Configuración
- **docker-compose.standalone.yml** - Para modo standalone (sin Traefik)
- **docker-compose.yml** - Para modo con Traefik

### Documentación
- **GUIA_DESPLEGUE_OPCIONES.md** - Guía completa de opciones

---

## 🔧 Comandos Rápidos

### Pruebas Locales (Sin Traefik)
```bash
cd /home/admin/site/cohortevidaypaz.com.co
git pull origin main
./deploy.sh
# Presiona: 2
# Esperar a que construya...
# Acceder a: http://localhost:8080
```

### Producción (Con Traefik)
```bash
cd /home/admin/site/cohortevidaypaz.com.co
git pull origin main

# Paso 1: Configurar Traefik
sudo ./setup-traefik.sh

# Paso 2: Desplegar
./deploy.sh
# Presiona: 1
# Esperar a que construya...
# Acceder a: https://www.cohortevidaypaz.com.co
```

---

## 📊 Comparación

| Modo | Traefik | HTTPS | Complejidad | Tiempo |
|-------|-----------|--------|--------------|---------|
| Standalone | ❌ | ❌ | ⭐ Simple | ⚡ Rápido |
| Con Traefik | ✅ | ✅ | ⭐⭐ Completo | 🐌 Más lento |

---

## ✨ Conclusión

**El problema está resuelto. Ahora tienes 3 opciones de despliegue:**

1. **Opción 1 (Traefik):** Para producción con HTTPS
2. **Opción 2 (Standalone):** Para pruebas locales sin Traefik ← RECOMENDADO
3. **Opción 3 (Auto-config):** Configura Traefik automáticamente

**Para pruebas locales, selecciona la OPCIÓN 2.**

---

## 🔄 Pasos en el Servidor

```bash
# 1. Actualizar desde GitHub
cd /home/admin/site/cohortevidaypaz.com.co
git pull origin main

# 2. Ejecutar despliegue
./deploy.sh

# 3. Seleccionar OPCIÓN 2 (Standalone)
# Presiona: 2

# 4. Esperar a que construya y levante

# 5. Acceder al sitio web
curl http://localhost:8080
# o en tu navegador: http://localhost:8080
```

---

## 📞 Ayuda

- Ver `GUIA_DESPLEGUE_OPCIONES.md` para más detalles
- Ver `setup-traefik.sh` para configuración automática
- Contacto: info@cohortevidaypaz.com.co

---

**🔗 Repositorio:** https://github.com/Agamenox/cohortevidaypaz.com.co

**✅ Las opciones de despliegue están listas en GitHub**

---

*Actualizado el 17 de Marzo de 2026*
*© 2024 Cohorte Vida y Paz. Todos los derechos reservados.*
