
# Build con Flutter ------------------------------------------------------
FROM ghcr.io/cirruslabs/flutter:3.19.6 AS builder

# Permite ejecutar flutter como root (necesario en Docker)
ENV FLUTTER_ALLOW_ROOT=true

# Argumento de build para variables de entorno dentro del código de la app
ARG BASE_URL=http://localhost:8080

# Directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia el proyecto entero
COPY . .

# Instala dependencias y genera la versión web optimizada
RUN flutter pub get
RUN flutter build web --release --dart-define=BASE_URL=$BASE_URL


# Producción con NGINX --------------------------------------------------
FROM nginx:alpine

# Limpia el contenido por defecto de NGINX
RUN rm -rf /usr/share/nginx/html/*

# Copia los assets web compilados desde la etapa de build
COPY --from=builder /app/build/web /usr/share/nginx/html

# Copia configuración simple para SPA (opcional)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expone el puerto habitual de NGINX
EXPOSE 80

# Arranca NGINX en foreground
CMD ["nginx", "-g", "daemon off;"]
