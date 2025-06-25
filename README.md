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

### RBAC 

kubectl auth can-i delete pods --as=system:serviceaccount:default:flask-app-sa

### NetworkPolicy

positif

kubectl run frontend --rm -it --image=busybox --labels="role=frontend" -- sh
# Dans le shell :
wget -O- http://flask-service1

Negatif

kubectl run attacker --rm -it --image=busybox -- sh
# wget -O- http://flask-service1



