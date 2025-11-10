# Système de Gestion des Stages

## 📋 Description

Application web complète pour la gestion des stages étudiants, développée avec Spring Boot (backend) et Angular (frontend). Le système permet aux étudiants, entreprises, enseignants et administrateurs de gérer efficacement le processus de stages.

## 🏗️ Architecture

### Backend (Spring Boot)
- **Framework**: Spring Boot 3.5.4
- **Base de données**: PostgreSQL
- **Sécurité**: JWT + Spring Security
- **Documentation API**: Swagger/OpenAPI
- **Communication temps réel**: WebSocket

### Frontend (Angular)
- **Framework**: Angular 17.3
- **UI**: Bootstrap 5.3 + Tailwind CSS
- **Communication**: WebSocket + HTTP
- **Composants**: ng-bootstrap

## 🚀 Fonctionnalités

### 👨‍🎓 Étudiants
- Consultation des offres de stage
- Candidature aux offres
- Gestion du profil
- Suivi des candidatures
- Gestion des conventions
- Rédaction de rapports hebdomadaires
- Messagerie

### 🏢 Entreprises
- Publication d'offres de stage
- Gestion des candidatures reçues
- Validation des conventions
- Suivi des stagiaires
- Messagerie

### 👨‍🏫 Enseignants
- Supervision des étudiants
- Validation des rapports
- Gestion des conventions
- Suivi pédagogique

### 🔧 Administrateurs
- Gestion des utilisateurs
- Gestion des rôles
- Statistiques globales
- Logs système
- Configuration

## 📁 Structure du Projet

```
gestionDesStages/
├── backend/                    # API Spring Boot
│   ├── src/main/java/
│   │   └── com/groupe/gestionDesStages/
│   │       ├── config/         # Configuration Swagger
│   │       ├── controller/     # Contrôleurs REST
│   │       ├── dto/           # Data Transfer Objects
│   │       ├── exception/     # Gestion des exceptions
│   │       ├── models/        # Entités JPA
│   │       ├── repository/    # Repositories JPA
│   │       ├── security/      # Configuration sécurité
│   │       ├── service/       # Services métier
│   │       ├── validator/     # Validateurs
│   │       └── websocket/     # Configuration WebSocket
│   └── src/main/resources/
│       ├── application.yml    # Configuration application
│       └── db/migration/      # Scripts de migration
├── frontend/                  # Application Angular
│   └── src/app/
│       ├── core/             # Services et guards
│       ├── features/         # Modules fonctionnels
│       └── shared/           # Composants partagés
└── README.md
```

## 🛠️ Installation et Configuration

### Prérequis
- Java 17+
- Node.js 18+
- PostgreSQL 12+
- Maven 3.6+

### Configuration Base de Données

1. Créer la base de données PostgreSQL :
```sql
CREATE DATABASE gestion_des_stages;
CREATE USER hels WITH PASSWORD 'hels';
GRANT ALL PRIVILEGES ON DATABASE gestion_des_stages TO hels;
```

2. Configurer `application.yml` :
```yaml
spring:
  datasource:
    url: jdbc:postgresql://localhost:5432/gestion_des_stages
    username: hels
    password: hels
```

### Installation Backend

```bash
cd gestionDesStages
mvn clean install
mvn spring-boot:run
```

L'API sera accessible sur `http://localhost:8080`

### Installation Frontend

```bash
cd frontend
npm install
npm start
```

L'application sera accessible sur `http://localhost:4200`

## 🔐 Sécurité

### Authentification JWT
- Durée de validité : 24h (86400000ms)
- Clé secrète configurée dans `application.yml`
- Refresh automatique des tokens

### Rôles et Permissions
- **ADMIN** : Accès complet au système
- **ETUDIANT** : Gestion profil, candidatures, rapports
- **ENTREPRISE** : Gestion offres, candidatures reçues
- **ENSEIGNANT** : Supervision étudiants, validation rapports

## 📡 API Documentation

### Endpoints Principaux

#### Authentification
- `POST /api/auth/login` - Connexion
- `POST /api/auth/register` - Inscription

#### Utilisateurs
- `GET /api/utilisateurs` - Liste des utilisateurs
- `PUT /api/utilisateurs/{id}` - Mise à jour profil

#### Offres
- `GET /api/offres` - Liste des offres
- `POST /api/offres` - Créer une offre
- `PUT /api/offres/{id}` - Modifier une offre

#### Candidatures
- `GET /api/candidatures` - Liste des candidatures
- `POST /api/candidatures` - Postuler à une offre
- `PUT /api/candidatures/{id}/statut` - Changer statut

#### Conventions
- `GET /api/conventions` - Liste des conventions
- `POST /api/conventions` - Créer une convention

#### Rapports
- `GET /api/rapports-hebdomadaires` - Liste des rapports
- `POST /api/rapports-hebdomadaires` - Créer un rapport

### Documentation Swagger
Accessible sur `http://localhost:8080/swagger-ui.html`

## 🔄 Communication Temps Réel

### WebSocket Endpoints
- `/ws` - Point d'entrée WebSocket
- `/topic/notifications/{userId}` - Notifications utilisateur
- `/topic/messages/{conversationId}` - Messages en temps réel

## 📊 Modèle de Données

### Entités Principales

#### Utilisateur
```java
@Entity
public class Utilisateur {
    private Long id;
    private String nom;
    private String prenom;
    private String email;
    private String motDePasse;
    private Set<Role> roles;
    private Boolean actif;
}
```

#### Offre
```java
@Entity
public class Offre {
    private Long id;
    private String titre;
    private String description;
    private String competencesRequises;
    private Date dateDebut;
    private Date dateFin;
    private Entreprise entreprise;
}
```

#### Candidature
```java
@Entity
public class Candidature {
    private Long id;
    private Etudiant etudiant;
    private Offre offre;
    private StatutCandidature statut;
    private String lettreMotivation;
    private Date datePostulation;
}
```

## 🐳 Déploiement Docker (Recommandé)

### Démarrage Rapide
```bash
# Vérifier les ports et démarrer
./scripts/start-app.sh

# Ou manuellement
docker compose up --build -d
```

### URLs d'Accès
- **Application**: http://localhost:4200
- **API**: http://localhost:8080  
- **Swagger**: http://localhost:8080/swagger-ui.html

📖 **Documentation complète**: [DOCKER.md](DOCKER.md)

## 🚀 Déploiement Manuel

### Variables d'Environnement
```bash
# Base de données
DB_URL=jdbc:postgresql://localhost:5432/gestion_des_stages
DB_USERNAME=hels
DB_PASSWORD=hels

# JWT
JWT_SECRET=your-secret-key
JWT_EXPIRATION=86400000

# Upload de fichiers
UPLOAD_DIR=/path/to/uploads
```

### Build Production

#### Backend
```bash
mvn clean package -Pprod
java -jar target/gestionDesStages-0.0.1-SNAPSHOT.jar
```

#### Frontend
```bash
ng build --configuration production
```

## 🧪 Tests

### Backend
```bash
mvn test
```

### Frontend
```bash
npm test
```

## 📝 Logs

Les logs sont configurés dans `application.yml` :
- Niveau DEBUG pour le développement
- Niveau INFO pour la production
- Logs SQL activés en développement

## 🤝 Contribution

1. Fork le projet
2. Créer une branche feature (`git checkout -b feature/nouvelle-fonctionnalite`)
3. Commit les changements (`git commit -am 'Ajout nouvelle fonctionnalité'`)
4. Push vers la branche (`git push origin feature/nouvelle-fonctionnalite`)
5. Créer une Pull Request

## 📄 Licence

Ce projet est sous licence MIT. Voir le fichier `LICENSE` pour plus de détails.

## 🆘 Support

Pour toute question ou problème :
- Créer une issue sur GitHub
- Consulter la documentation Swagger
- Vérifier les logs de l'application

## 🔧 Dépannage

### Problèmes Courants

#### Erreur de connexion à la base de données
```bash
# Vérifier que PostgreSQL est démarré
sudo systemctl status postgresql

# Vérifier les credentials dans application.yml
```

#### Erreur CORS
```bash
# Vérifier la configuration proxy dans proxy.conf.json
# S'assurer que le backend autorise les requêtes du frontend
```

#### Problème de build Angular
```bash
# Nettoyer le cache
npm cache clean --force
rm -rf node_modules package-lock.json
npm install
```

## 📈 Roadmap

- [ ] Intégration avec des services externes (LinkedIn, Indeed)
- [ ] Module de notation des stages
- [ ] Génération automatique de rapports PDF
- [ ] Application mobile
- [ ] Intégration avec des outils de visioconférence