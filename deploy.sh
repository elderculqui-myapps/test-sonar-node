#!/bin/bash

APP_NAME="testsonarnode"
IMAGE="dockerhub.mateohost.online/$APP_NAME:latest"

# Detener y eliminar contenedor anterior si existe
docker stop $APP_NAME || true
docker rm $APP_NAME || true

# Eliminar imagen anterior para evitar caché
docker rmi $IMAGE || true

# Obtener nueva imagen
docker pull $IMAGE

# Ejecutar contenedor
docker run -d --name $APP_NAME -p 3000:3000 $IMAGE