#!/bin/bash

echo "🚀 Démarrage de l'application Gestion des Stages"

# Vérifier les ports
./scripts/check-ports.sh
if [ $? -ne 0 ]; then
    exit 1
fi

# Construire et démarrer les conteneurs
echo "📦 Construction et démarrage des conteneurs..."
docker compose up --build -d

# Attendre que les services soient prêts
echo "⏳ Attente du démarrage des services..."
sleep 30

# Vérifier le statut
echo "📊 Statut des conteneurs:"
docker compose ps

echo ""
echo "🎉 Application démarrée!"
echo "Frontend: http://localhost:4200"
echo "Backend API: http://localhost:8080"
echo "Swagger: http://localhost:8080/swagger-ui.html"
echo ""
echo "Pour voir les logs: docker compose logs -f"