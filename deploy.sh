#!/bin/bash

APP_NAME="flask-app"
IMAGE_NAME="flask-wvg:latest"
SERVICE_NAME="flask-service"
PORT=30007

echo "🔧 Configuration de l'environnement Docker pour Minikube..."
eval $(minikube docker-env)

echo "🐳 Construction de l'image Docker [$IMAGE_NAME]..."
docker build -t $IMAGE_NAME .

echo "📦 Application du déploiement Kubernetes..."
kubectl apply -f manifests/deployment.yaml

echo "🌐 Application du service Kubernetes..."
kubectl apply -f manifests/service.yaml

echo "♻️ Redémarrage du déploiement [$APP_NAME]..."
kubectl rollout restart deployment $APP_NAME

echo "⏳ Attente que le pod soit prêt..."
kubectl wait --for=condition=available deployment/$APP_NAME --timeout=60s

echo "🌐 Test du endpoint /health sur le service exposé..."
SERVICE_IP=$(minikube ip)
RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" http://$SERVICE_IP:$PORT/health)

if [ "$RESPONSE" -eq 200 ]; then
  echo "✅ L'application est fonctionnelle !"
  echo "➡️ Accès à : http://$SERVICE_IP:$PORT/"
  echo "➡️ Healthcheck : http://$SERVICE_IP:$PORT/health"
else
  echo "❌ Échec du test : code HTTP $RESPONSE"
  echo "🔍 Vérifiez les logs avec : kubectl logs -l app=$APP_NAME"
fi

