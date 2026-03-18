FROM nginx:alpine

LABEL maintainer="Cohorte Vida y Paz <info@cohortevidaypaz.com.co>"
LABEL description="Sitio web de Cohorte Vida y Paz - Estudio longitudinal en Colombia"

RUN apk add --no-cache ca-certificates

COPY index.html /usr/share/nginx/html/
COPY css/ /usr/share/nginx/html/css/
COPY js/ /usr/share/nginx/html/js/
COPY images/ /usr/share/nginx/html/images/ 2>/dev/null || mkdir -p /usr/share/nginx/html/images/

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget --quiet --tries=1 --spider http://127.0.0.1/ || exit 1

CMD ["nginx", "-g", "daemon off;"]
