# Flask Vuln App – Projet EI

Cette application Flask volontairement vulnérable est utilisée pour tester l'intégration de scans de sécurité dans un pipeline DevSecOps local.


---

## 🚀 Étapes de déploiement local dans Minikube

### 1️⃣ Démarrer Minikube

```bash
minikube start --driver=docker --cpus=2 --memory=4096

eval $(minikube docker-env)

docker build -t flask-test:latest .

kubectl apply -f manifests/

kubectl apply -f manifests/deployment.yaml

kubectl apply -f manifests/service.yaml

kubectl rollout restart deployment flask-app

minikube service flask-service




