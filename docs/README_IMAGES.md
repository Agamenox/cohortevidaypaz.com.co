# 🖼️ Directorio de Imágenes

Este directorio contiene las imágenes utilizadas en el sitio web de Cohorte Vida y Paz.

## 📝 Agregar Imágenes

### Formatos Soportados
- JPEG/JPG
- PNG
- SVG
- GIF
- WebP
- ICO

### Tamaños Recomendados

| Tipo | Dimensiones | Uso |
|------|--------------|------|
| Hero Background | 1920x1080 | Fondo de sección principal |
| Logo | 200x200 | Logo de la marca |
| Icons | 64x64 | Iconos pequeños |
| Cards | 800x600 | Imágenes de tarjetas |

### Cómo Agregar Imágenes

1. Copia tus archivos de imagen al directorio `images/`
2. Los archivos se copiarán automáticamente al contenedor durante el despliegue
3. Referencia las imágenes en el HTML usando la ruta `/images/tu-imagen.jpg`

### Ejemplo

```html
<img src="/images/logo.png" alt="Logo de Cohorte Vida y Paz">
<img src="/images/team.jpg" alt="Equipo de investigación">
```

## 📏️ Optimización

Para mejorar el rendimiento:

1. **Comprimir imágenes:** Usa herramientas como TinyPNG o Squoosh
2. **Formato moderno:** Usa WebP cuando sea posible
3. **Lazy loading:** Agrega `loading="lazy"` a imágenes fuera del viewport
4. **Responsive:** Usa atributos `srcset` para imágenes responsivas

### Ejemplo de Optimización

```html
<img
  src="/images/team.jpg"
  srcset="/images/team-small.jpg 640w,
          /images/team-medium.jpg 1024w,
          /images/team-large.jpg 1920w"
  sizes="(max-width: 640px) 100vw,
         (max-width: 1024px) 100vw,
         1920px"
  alt="Equipo de investigación"
  loading="lazy"
  width="1920"
  height="1080">
```

## 🔧 Notas Técnicas

- El directorio se copia al contenedor Docker durante el build
- Las imágenes se sirven estáticamente por Nginx
- El caché de imágenes está configurado por 1 año
- Usa nombres de archivos descriptivos y en minúsculas

## 📂 Estructura Actual

```
images/
└── .gitkeep    # Mantiene el directorio en Git
```

Agrega aquí tus archivos de imagen.

---

© 2024 Cohorte Vida y Paz. Todos los derechos reservados.
