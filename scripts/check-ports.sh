#!/bin/bash

echo "🔍 Vérification des ports utilisés..."

PORTS=(4200 8080 5433)
CONFLICTS=false

for port in "${PORTS[@]}"; do
    if lsof -i :$port > /dev/null 2>&1; then
        echo "❌ Port $port est déjà utilisé:"
        lsof -i :$port
        CONFLICTS=true
    else
        echo "✅ Port $port est libre"
    fi
done

if [ "$CONFLICTS" = true ]; then
    echo ""
    echo "⚠️  Des conflits de ports ont été détectés!"
    echo "Arrêtez les services conflictuels avant de lancer Docker:"
    echo "sudo systemctl stop nginx apache2 postgresql"
    exit 1
else
    echo ""
    echo "🎉 Tous les ports sont libres, vous pouvez lancer Docker!"
fi