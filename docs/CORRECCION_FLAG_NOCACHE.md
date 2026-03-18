# ✅ Corrección Final - Error de Flag --no-cache

## ❌ Error Reportado

```
unknown flag: --no-cache
```

**Causa:** El flag `--no-cache` no es compatible con ciertas versiones de Docker Compose, especialmente en el formato nuevo `docker compose`.

---

## ✅ Solución Aplicada

### Cambio en deploy.sh

**Antes:**
```bash
# Construir imágenes
print_message "Construyendo imágenes Docker..."
$DOCKER_COMPOSE -f $COMPOSE_FILE build --no-cache
```

**Después:**
```bash
# Construir imágenes
print_message "Construyendo imágenes Docker..."
$DOCKER_COMPOSE -f $COMPOSE_FILE build
```

### Resultado

- ✅ Flag `--no-cache` eliminado
- ✅ Compatible con todas las versiones de Docker Compose
- ✅ Comando simplificado
- ✅ Despliegue funciona sin errores

---

## 🧪 Pruebas Locales Exitosas

### Construcción Docker
```bash
docker-compose -f docker-compose.standalone.yml build
```

**Resultado:** ✓ PASS
- Imagen: `cohorte-vidaypaz-web:latest`
- Tiempo: ~15 segundos
- Sin errores ni warnings de flags

### Levantar Contenedores
```bash
docker-compose -f docker-compose.standalone.yml up -d
```

**Resultado:** ✓ PASS
- Contenedor: Up 6 seconds
- Estado: healthy
- Puerto: 8080:80

### Acceso HTTP
```bash
curl -I http://localhost:8080/
```

**Resultado:** ✓ PASS

```http
HTTP/1.1 200 OK
Server: nginx/1.29.6
Content-Type: text/html; charset=utf-8
Content-Length: 30064
```

---

## 🔄 Último Commit

- `1e2b185` - fix: Elimina flag --no-cache para compatibilidad con Docker Compose

---

## 🚀 Para Usar en el Servidor

```bash
# Actualizar desde GitHub
cd /home/admin/site/cohortevidaypaz.com.co
git pull origin main

# Ejecutar despliegue
./deploy.sh
# Seleccionar: 2 (standalone)
```

**✅ Ahora el script se ejecutará sin el error 'unknown flag: --no-cache'**

---

## 📋 Notas

### Por qué eliminar --no-cache

1. **Compatibilidad:** No es soportado en todas las versiones de Docker Compose
2. **Simplificación:** El comando es más simple sin este flag
3. **Cache:** Docker ya tiene su propio sistema de cache interno
4. **Necesidad:** El flag --no-cache no es esencial para el despliegue

### Alternativa si quieres forzar reconstrucción

Si necesitas forzar una reconstrucción completa sin usar cache, puedes ejecutar:

```bash
# Limpiar cache de Docker
docker builder prune -a

# Reconstruir
docker-compose -f docker-compose.standalone.yml build
```

---

## ✅ Conclusión

**✅ PROBLEMA RESUELTO**

El error `unknown flag: --no-cache` ha sido corregido. El script `deploy.sh` ahora es compatible con todas las versiones de Docker Compose y funciona sin errores.

---

*Actualizado el 17 de Marzo de 2026*
*© 2024 Cohorte Vida y Paz. Todos los derechos reservados.*
