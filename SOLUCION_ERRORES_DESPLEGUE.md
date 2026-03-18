# 🔧 Guía de Solución de Errores de Despliegue

## 📅 Fecha: 17 de Marzo de 2026

---

## ❌ Error Encontrado

Al ejecutar `./deploy.sh` en el servidor, ocurren los siguientes errores:

### 1. Warnings de Variables de Entorno
```
WARN[0000] The "apr1" variable is not set. Defaulting to a blank string.
WARN[0000] The "FGt9DQ3y" variable is not set. Defaulting to a blank string.
```

**Causa:** El hash htpasswd en `.env` contiene caracteres `$` que Docker intenta interpretar como variables de entorno.

### 2. Error al Copiar Directorio images/
```
ERROR [6/7] COPY images/ /usr/share/nginx/html/images/:
------
 > [6/7] COPY images/ /usr/share/nginx/html/images/:
------
failed to solve: failed to compute cache key: failed to calculate checksum of ref ...: "/images": not found
```

**Causa:** El directorio `images/` está vacío y Docker no puede copiar directorios vacíos.

---

## ✅ Soluciones Aplicadas

### 1. Crear Archivo .gitkeep en images/

Se ha creado el archivo `images/.gitkeep` para que el directorio no esté completamente vacío.

### 2. Actualizar .env.example con Comillas

**Antes:**
```bash
TRAEFIK_BASIC_AUTH=admin:$apr1$random$hash
```

**Después:**
```bash
TRAEFIK_BASIC_AUTH='admin:$apr1$random$hash'
```

Las comillas simples previenen que Docker interprete los caracteres `$` como variables.

### 3. Modificar deploy.sh

Se ha actualizado el script para crear el directorio `images/` si no existe:

```bash
# Verificar directorio images
print_message "Verificando directorio images..."
if [ ! -d images ]; then
    print_message "Creando directorio images..."
    mkdir -p images
    touch images/.gitkeep
fi
```

### 4. Actualizar Dockerfile

Se ha modificado para manejar directorios vacíos:

```dockerfile
COPY images/ /usr/share/nginx/html/images/ 2>/dev/null || mkdir -p /usr/share/nginx/html/images/
```

---

## 🚀 Cómo Arreglar en el Servidor

### Opción 1: Actualizar desde GitHub (Recomendado)

```bash
# Ir al directorio del proyecto
cd /home/admin/site/cohortevidaypaz.com.co

# Actualizar desde GitHub
git pull origin main

# Ejecutar script de despliegue
./deploy.sh
```

### Opción 2: Correcciones Manuales

Si prefieres hacer las correcciones manualmente:

#### Paso 1: Crear directorio images/
```bash
mkdir -p images
touch images/.gitkeep
```

#### Paso 2: Actualizar .env

Editar el archivo `.env` y agregar comillas simples al valor de `TRAEFIK_BASIC_AUTH`:

```bash
nano .env
```

Cambiar:
```bash
TRAEFIK_BASIC_AUTH=admin:$apr1$.....
```

Por:
```bash
TRAEFIK_BASIC_AUTH='admin:$apr1$.....'
```

#### Paso 3: Regenerar Contraseña (Opcional)

Si quieres generar una nueva contraseña:

```bash
./generate-password.sh admin
```

Copiar el resultado y pegarlo en `.env` con comillas simples.

#### Paso 4: Ejecutar Despliegue

```bash
./deploy.sh
```

---

## 📋 Checklist para Despliegue Exitoso

Antes de ejecutar `./deploy.sh`, verificar:

- [ ] Docker instalado
- [ ] Docker Compose instalado
- [ ] Red `traefik-network` creada
- [ ] Directorio `/etc/traefik` creado
- [ ] Archivo `/etc/traefik/acme.json` creado con permisos 600
- [ ] Archivo `.env` existe y configurado
- [ ] Directorio `images/` existe
- [ ] Valor de `TRAEFIK_BASIC_AUTH` tiene comillas simples

---

## 🧪 Pruebas Posteriores

Después del despliegue, verificar:

### 1. Verificar Contenedores
```bash
docker-compose ps
```

Esperado: `Up` con estado healthy

### 2. Verificar Logs
```bash
docker-compose logs -f
```

Esperado: Sin errores de Nginx

### 3. Probar Sitio Web
```bash
curl -I http://localhost
```

Esperado: `HTTP/1.1 200 OK`

### 4. Probar Traefik Dashboard
```
URL: http://traefik.cohortevidaypaz.com.co:8080
```

Esperado: Dashboard accesible con autenticación

---

## 📞 Soporte

Si los errores persisten:

1. **Verificar Logs Detallados:**
   ```bash
   docker-compose logs web --tail=100
   docker-compose logs traefik --tail=100
   ```

2. **Verificar Configuración de Nginx:**
   ```bash
   docker exec cohorte-vidaypaz-web cat /etc/nginx/nginx.conf
   ```

3. **Verificar Archivos en Contenedor:**
   ```bash
   docker exec cohorte-vidaypaz-web ls -la /usr/share/nginx/html/
   ```

4. **Contactar:**
   - Email: info@cohortevidaypaz.com.co
   - GitHub: https://github.com/Agamenox/cohortevidaypaz.com.co/issues

---

## 📝 Notas Adicionales

### Por Qué Ocurre el Error de Variables

El formato de hash htpasswd es:
```
usuario:$apr1$salt$hash
```

Docker intenta interpretar:
- `apr1` como variable
- `salt` como variable

Al usar comillas simples `'...'`, Docker trata el valor como una cadena literal y no intenta expandir variables.

### Por Qué Falla el Directorio images/

Docker no puede copiar directorios vacíos porque no puede calcular un checksum de archivos que no existen. El archivo `.gitkeep` es una convención de Git para mantener directorios vacíos en el repositorio.

---

## ✨ Conclusión

Las correcciones han sido aplicadas y subidas a GitHub. El despliegue ahora debería funcionar sin errores.

**Comando recomendado:**
```bash
git pull origin main && ./deploy.sh
```

---

*Actualizado el 17 de Marzo de 2026*
*© 2024 Cohorte Vida y Paz. Todos los derechos reservados.*
