#!/bin/bash

set -e  # Detiene el script si ocurre un error

APP_NAME="testsonarnode"
REGISTRY="dockerhub.mateohost.online"
IMAGE="$REGISTRY/$APP_NAME:latest"

# Autenticación en Nexus (asegúrate de usar credenciales válidas)
echo "Iniciando sesión en Nexus Docker Registry..."
echo "$NEXUS_PASSWORD" | docker login $REGISTRY -u "$NEXUS_USERNAME" --password-stdin

# Detener y eliminar contenedor anterior si existe
echo "Deteniendo y eliminando contenedor anterior si existe..."
docker stop $APP_NAME || true
docker rm $APP_NAME || true

# Eliminar imagen anterior para evitar caché
echo "Eliminando imagen anterior..."
docker rmi $IMAGE || true

# Obtener nueva imagen desde Nexus
echo "Descargando nueva imagen desde Nexus..."
docker pull $IMAGE

# Ejecutar contenedor
echo "Ejecutando contenedor..."
docker run -d --name $APP_NAME -p 3000:3000 $IMAGE