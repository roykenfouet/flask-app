# Étape 1 : Image de base
FROM python:3.10-slim

# Étape 2 : Répertoire de travail
WORKDIR /app

# Étape 3 : Dépendances
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Étape 4 : Code source
COPY . .

# Étape 5 : Exposer le port
EXPOSE 5000

# Étape 6 : Commande de démarrage
CMD ["python", "app.py"]

