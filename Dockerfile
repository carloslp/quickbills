# Etapa 1: Construcción de la aplicación React
FROM node:18-alpine as build

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar package.json y package-lock.json (o yarn.lock) e instalar dependencias
COPY package.json package-lock.json ./
RUN npm install

# Copiar el código fuente de la aplicación React
COPY . ./

# Construir la aplicación para producción
RUN npm run build

# Etapa 2: Servir la aplicación con Nginx
FROM nginx:alpine

# Copiar los archivos de la construcción de la etapa anterior al directorio de Nginx
COPY --from=build /app/build /usr/share/nginx/html

# Exponer el puerto 80 para la aplicación
EXPOSE 80

# Comando por defecto de Nginx
CMD ["nginx", "-g", "daemon off;"]
