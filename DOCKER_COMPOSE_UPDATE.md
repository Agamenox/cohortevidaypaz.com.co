# 🔄 Actualización a Docker Compose (Nuevo Formato)

## 📅 Fecha: 17 de Marzo de 2026

---

## ❌ Problema

Al ejecutar `./deploy.sh` en Docker versión 29.3.0, ocurre el siguiente error:

```
[ERROR] Docker Compose no está instalado
```

**Causa:** En versiones recientes de Docker (v20.10+), el comando ha cambiado de:
- `docker-compose` (formato antiguo, instalado separadamente)
- `docker compose` (nuevo formato, integrado en Docker)

---

## ✅ Solución Aplicada

### 1. Actualización de deploy.sh

**Antes:**
```bash
# Verificaba solo docker-compose
if ! command -v docker-compose &> /dev/null; then
    print_error "Docker Compose no está instalado"
    exit 1
fi
DOCKER_COMPOSE="docker-compose"
```

**Después:**
```bash
# Detecta automáticamente el formato disponible
if docker compose version &> /dev/null 2>&1; then
    DOCKER_COMPOSE="docker compose"
    print_message "Docker Compose instalado (nuevo formato)"
elif command -v docker-compose &> /dev/null; then
    DOCKER_COMPOSE="docker-compose"
    print_message "Docker Compose instalado (formato antiguo)"
else
    print_error "Docker Compose no está instalado"
    exit 1
fi
```

### 2. Uso de Variable Dinámica

Todos los comandos en `deploy.sh` ahora usan `$DOCKER_COMPOSE`:

```bash
$DOCKER_COMPOSE down
$DOCKER_COMPOSE build --no-cache
$DOCKER_COMPOSE up -d
$DOCKER_COMPOSE ps
$DOCKER_COMPOSE logs -f
```

### 3. Actualización de Documentación

Se han actualizado todos los archivos de documentación:
- `README.md` - Referencias actualizadas a `docker compose`
- `INSTRUCCIONES_RAPIDAS.md` - Comandos actualizados
- `CLONAR_Y_DESPEGAR.md` - Ejemplos actualizados
- `SOLUCION_ERRORES_DESPLEGUE.md` - Referencias actualizadas
- `TAREAS_COMPLETADAS.md` - Referencias actualizadas
- `TESTING_REPORT.md` - Referencias actualizadas

---

## 📋 Compatibilidad

### Formato Nuevo (Docker 20.10+)

```bash
docker compose version
docker compose up -d
docker compose ps
docker compose logs -f
docker compose down
```

### Formato Antiguo (Docker < 20.10)

```bash
docker-compose --version
docker-compose up -d
docker-compose ps
docker-compose logs -f
docker-compose down
```

### Script deploy.sh

El script detecta automáticamente cuál usar:

```bash
./deploy.sh
# Detectará y usará el comando correcto automáticamente
```

---

## 🔧 Versiones de Docker

| Versión | Formato | Comando |
|----------|----------|----------|
| < 20.10 | Antiguo | `docker-compose` |
| >= 20.10 | Nuevo (recomendado) | `docker compose` |
| 29.3.0 | Nuevo | `docker compose` |

---

## 🚀 Cómo Usar

### En el Servidor

```bash
# Actualizar desde GitHub
cd /home/admin/site/cohortevidaypaz.com.co
git pull origin main

# El script ahora detectará automáticamente el formato correcto
./deploy.sh
```

### Comandos Manuales

```bash
# Nuevo formato (Docker 20.10+)
docker compose up -d
docker compose ps
docker compose logs -f

# Formato antiguo (si está instalado)
docker-compose up -d
docker-compose ps
docker-compose logs -f
```

---

## 📝 Notas Técnicas

### Por Qué el Cambio

1. **Integración:** Docker Compose ahora está integrado en Docker como plugin
2. **Simplicidad:** No requiere instalación separada
3. **Mantenimiento:** Recibe actualizaciones junto con Docker
4. **Estándar:** Es el formato oficial y recomendado

### Soporte de Retrocompatibilidad

El script `deploy.sh` mantiene soporte para ambos formatos:
- Prioriza el nuevo formato (`docker compose`)
- Si no está disponible, usa el antiguo (`docker-compose`)
- Adapta los comandos según el formato detectado

---

## ✅ Verificación

### Verificar Versión de Docker

```bash
docker --version
```

Esperado: `Docker version 20.10.0` o superior

### Verificar Comando de Compose

```bash
# Intentar nuevo formato
docker compose version

# Si falla, intentar antiguo
docker-compose --version
```

---

## 🔄 Cambios Realizados

### Archivos Modificados

- `deploy.sh` - Detecta automáticamente el formato de Docker Compose
- `README.md` - Actualizado para usar `docker compose`
- `INSTRUCCIONES_RAPIDAS.md` - Comandos actualizados
- `CLONAR_Y_DESPEGAR.md` - Referencias actualizadas
- `SOLUCION_ERRORES_DESPLEGUE.md` - Referencias actualizadas
- `TAREAS_COMPLETADAS.md` - Referencias actualizadas
- `TESTING_REPORT.md` - Referencias actualizadas

### Commits

- `e4c2ac6` - fix: Actualiza deploy.sh para usar docker compose (nuevo formato)

---

## 📞 Contacto

Para problemas o preguntas:
- Email: info@cohortevidaypaz.com.co
- Sitio web: https://www.cohortevidaypaz.com.co
- GitHub: https://github.com/Agamenox/cohortevidaypaz.com.co/issues

---

## ✨ Conclusión

**✅ SCRIPT ACTUALIZADO PARA DOCKER COMPOSE NUEVO FORMATO**

El script `deploy.sh` ahora soporta automáticamente tanto el formato antiguo como el nuevo de Docker Compose, permitiendo despliegues exitosos en cualquier versión de Docker.

---

*Actualizado el 17 de Marzo de 2026*
*© 2024 Cohorte Vida y Paz. Todos los derechos reservados.*
