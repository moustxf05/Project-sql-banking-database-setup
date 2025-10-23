# SAE 2.01 : Base de Données Bancaires (SQL) 🏦📊

Ce projet, réalisé dans le cadre de la **SAE 2.01 (BUT Science des Données)**, consiste à **structurer et alimenter une base de données relationnelle** (probablement PostgreSQL) à partir d'un fichier de données bancaires pré-nettoyées (`sae_donnees_bancaires_nettoyee.csv`).

---

## Objectif du Projet

L'objectif est de mettre en place une base de données fonctionnelle permettant de stocker et d'interroger des informations bancaires (clients, comptes, transactions, etc.). Cela comprend :

* La **conception du schéma** de la base de données.
* La **création des tables et des vues** nécessaires à l'analyse.
* Le **chargement (population)** des données nettoyées dans la base.

---

## Processus et Méthodologie ⚙️

Le projet se concentre sur la partie "Load" (Chargement) et structuration d'un processus ETL, les données étant déjà transformées (nettoyées) :

1.  **Définition de la Structure (SQL) :**
    * Le script `script_table_vues.sql` contient les instructions `CREATE TABLE` pour définir les différentes entités (Clients, Comptes, Opérations...) et leurs relations, ainsi que `CREATE VIEW` pour créer des requêtes pré-définies simplifiant l'accès aux informations.
2.  **Alimentation de la Base (SQL) :**
    * Le script `alimentation_table.sql` utilise les données du fichier `sae_donnees_bancaires_nettoyee.csv` pour insérer les enregistrements dans les tables créées précédemment, probablement via des commandes `INSERT INTO` ou une commande `COPY` spécifique à PostgreSQL.

*(Note : L'étape de nettoyage initiale ayant produit `sae_donnees_bancaires_nettoyee.csv` n'est pas incluse dans les scripts de ce dépôt mais est documentée dans le rapport.)*

---

## Technologies et Outils Utilisés 🛠️

* **Langage :** SQL
* **SGBD :** PostgreSQL (fortement suggéré par la syntaxe SQL et le contexte universitaire)
* **Format de données d'entrée :** CSV

---

## Structure du Dépôt 🗂️

* `sae_donnees_bancaires_nettoyee.csv`: Fichier CSV contenant les données bancaires nettoyées, prêtes à être importées.
* `script_table_vues.sql`: Script SQL pour la création de la structure de la base de données (tables et vues).
* `alimentation_table.sql`: Script SQL pour l'insertion des données dans les tables.
* `Rapport-SAE 2.01.pdf`: Rapport détaillé du projet expliquant la démarche complète, y compris l'étape de nettoyage préalable non présente ici.

---

## Comment Utiliser ▶️

1.  **Prérequis :** Avoir un serveur PostgreSQL installé et accessible.
2.  **Création de la Base :** Créer une nouvelle base de données vide (par exemple, `banque_sae`).
3.  **Création de la Structure :** Exécuter le contenu du fichier `script_table_vues.sql` sur la base de données créée. Cela va générer les tables et les vues.
4.  **Chargement des Données :** Exécuter le contenu du fichier `alimentation_table.sql`. **Attention :** Ce script peut nécessiter une adaptation. S'il utilise une commande `COPY FROM`, il faudra ajuster le chemin d'accès au fichier `sae_donnees_bancaires_nettoyee.csv` pour qu'il soit correct depuis le serveur PostgreSQL ou l'outil client (comme psql ou PgAdmin). S'il contient de nombreuses commandes `INSERT`, il peut être exécuté directement.
5.  **Vérification :** Utiliser des requêtes `SELECT` pour vérifier que les données ont été correctement chargées dans les tables et que les vues fonctionnent.
