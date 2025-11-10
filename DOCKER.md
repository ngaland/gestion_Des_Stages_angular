# 🐳 Guide Docker - Gestion des Stages

## 🚀 Démarrage Rapide

```bash
# Vérifier les ports et démarrer
./scripts/start-app.sh

# Ou manuellement
./scripts/check-ports.sh
docker compose up --build -d
```

## 📋 Prérequis

- Docker 20.10+
- Docker Compose 2.0+
- Ports libres: 4200, 8080, 5433

## 🏗️ Architecture Docker

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Frontend      │    │    Backend      │    │   Database      │
│   Angular       │────│  Spring Boot    │────│  PostgreSQL     │
│   Port: 4200    │    │   Port: 8080    │    │   Port: 5433    │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

## 🔧 Configuration

### Ports Utilisés
- **Frontend**: 4200 (évite conflit avec port 80)
- **Backend**: 8080
- **Database**: 5433 (évite conflit avec PostgreSQL local)

### Variables d'Environnement
```yaml
DB_USERNAME: hels
DB_PASSWORD: hels
JWT_SECRET: [clé-sécurisée]
SPRING_PROFILES_ACTIVE: docker
```

## 📁 Structure Docker

```
gestionDesStages/
├── docker-compose.yml          # Orchestration des services
├── gestionDesStages/
│   ├── Dockerfile             # Backend Spring Boot
│   ├── .dockerignore
│   └── src/main/resources/
│       └── application-docker.yml
├── frontend/
│   ├── Dockerfile             # Frontend Angular
│   ├── nginx.conf             # Configuration Nginx
│   └── .dockerignore
└── scripts/
    ├── check-ports.sh         # Vérification ports
    └── start-app.sh          # Démarrage automatisé
```

## 🛠️ Commandes Utiles

### Démarrage
```bash
# Démarrage complet
docker compose up --build -d

# Voir les logs
docker compose logs -f

# Statut des conteneurs
docker compose ps
```

### Debug
```bash
# Logs d'un service spécifique
docker compose logs -f backend
docker compose logs -f frontend
docker compose logs -f database

# Accéder à un conteneur
docker exec -it gestion-stages-backend bash
docker exec -it gestion-stages-frontend sh
docker exec -it gestion-stages-db psql -U hels -d gestion_des_stages
```

### Maintenance
```bash
# Arrêter les services
docker compose down

# Nettoyer (supprime volumes)
docker compose down -v

# Rebuild complet
docker compose build --no-cache
```

## 🔍 Vérifications

### Healthchecks
- **Database**: `pg_isready`
- **Backend**: `/actuator/health`
- **Frontend**: Nginx status

### URLs d'Accès
- **Application**: http://localhost:4200
- **API**: http://localhost:8080
- **Swagger**: http://localhost:8080/swagger-ui.html

## 🚨 Résolution de Problèmes

### Port déjà utilisé
```bash
# Vérifier les ports
sudo lsof -i :4200 -i :8080 -i :5433

# Arrêter services conflictuels
sudo systemctl stop nginx apache2 postgresql
```

### Erreur de build Angular
```bash
# Nettoyer le cache Docker
docker system prune -f

# Rebuild sans cache
docker compose build --no-cache frontend
```

### Base de données non accessible
```bash
# Vérifier les logs
docker compose logs database

# Recréer le volume
docker compose down -v
docker compose up -d database
```

### Backend ne démarre pas
```bash
# Vérifier les logs
docker compose logs backend

# Variables d'environnement
docker exec gestion-stages-backend env | grep -E "(DB_|JWT_|SPRING_)"
```

## 📊 Monitoring

### Logs en Temps Réel
```bash
# Tous les services
docker compose logs -f

# Service spécifique
docker compose logs -f backend
```

### Métriques
```bash
# Utilisation ressources
docker stats

# Espace disque
docker system df
```

## 🔒 Sécurité

### Variables Sensibles
- JWT_SECRET: Changez en production
- DB_PASSWORD: Utilisez des mots de passe forts
- Ports: Utilisez un reverse proxy en production

### Volumes
- `postgres_data`: Données persistantes
- `uploads_data`: Fichiers uploadés

## 🚀 Production

### Optimisations
```yaml
# docker-compose.prod.yml
services:
  backend:
    environment:
      SPRING_PROFILES_ACTIVE: prod
    deploy:
      resources:
        limits:
          memory: 1G
        reservations:
          memory: 512M
```

### Reverse Proxy
```nginx
# nginx.conf (production)
upstream backend {
    server backend:8080;
}

server {
    listen 80;
    location / {
        proxy_pass http://frontend;
    }
    location /api/ {
        proxy_pass http://backend;
    }
}
```