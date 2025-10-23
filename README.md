# SAE 2.01 : Traitement de Données Bancaires (Python & SQL) 🏦🐍📊

Ce projet, réalisé dans le cadre de la **SAE 2.01 (BUT Science des Données)**, met en œuvre un pipeline complet pour **traiter des données bancaires brutes**. Il comprend une phase de **nettoyage** avec Python (`nettoyage_donnees.py`) et une phase d'**intégration et structuration** dans une base de données PostgreSQL via SQL (`script_table_vues.sql`, `alimentation_table.sql`).

---

## Objectif du Projet

L'objectif principal est de transformer un fichier de données bancaires initial (`sae_donnees_bancaires.csv`) en une **base de données relationnelle structurée et exploitable**. Cela implique :

* **Nettoyer** les données brutes, notamment en **standardisant les formats de date** et en gérant les erreurs.
* **Concevoir et créer** une structure de base de données (tables, vues) adaptée.
* **Alimenter** la base de données avec les données nettoyées (`sae_donnees_bancaires_nettoyee.csv`).

---

## Processus et Méthodologie ⚙️

Le projet suit un processus ETL (Extract, Transform, Load) :

1.  **Extraction & Transformation (Python) :**
    * Le script `nettoyage_donnees.py` charge les données bancaires initiales depuis `sae_donnees_bancaires.csv`.
    * Il applique une fonction `safe_parse_date` pour **nettoyer et convertir** plusieurs colonnes de dates (`ddn`, `date_rattachement`, `dt_mouvement`, `date_parrainage`, `ddn_agent`) au format 'AAAA-MM-JJ', en gérant les erreurs de parsing. Il utilise la bibliothèque **Pandas** pour ces opérations.
    * Le résultat est sauvegardé dans le fichier `sae_donnees_bancaires_nettoyee.csv`.
2.  **Chargement & Structuration (SQL - PostgreSQL) :**
    * Le script `script_table_vues.sql` définit la structure de la base de données : création des **tables** (par ex. clients, comptes, transactions) et des **vues**.
    * Le script `alimentation_table.sql` utilise les données du fichier nettoyé `sae_donnees_bancaires_nettoyee.csv` pour **insérer les enregistrements** dans les tables créées.

---

## Technologies et Outils Utilisés 🛠️

* **Langages :** Python 3.x, SQL
* **Bibliothèque Python :** Pandas
* **SGBD :** PostgreSQL (fortement suggéré par la syntaxe SQL et le rapport)
* **Format de données :** CSV

---

## Structure du Dépôt 🗂️

* `nettoyage_donnees.py`: Script Python pour le nettoyage des dates.
* `sae_donnees_bancaires_nettoyee.csv`: Fichier CSV contenant les données après nettoyage.
* `script_table_vues.sql`: Script SQL pour la création des tables et des vues dans la base de données.
* `alimentation_table.sql`: Script SQL pour l'insertion des données nettoyées dans les tables.
* `Rapport-SAE 2.01.pdf`: Rapport détaillé du projet expliquant la démarche complète.
* `sae_donnees_bancaires.csv` (fichier brut d'entrée pour le script Python).

---

## Comment Utiliser ▶️

1.  **Prérequis Python :** Avoir Python 3 et la bibliothèque Pandas installés (`pip install pandas`).
2.  **Nettoyage :**
    * Placer le fichier de données bancaires brutes (non inclus) dans le même répertoire que `nettoyage_donnees.py` et **le nommer** `sae_donnees_bancaires.csv`.
    * Exécuter le script : `python nettoyage_donnees.py`. Le fichier `sae_donnees_bancaires_nettoyee.csv` sera généré.
3.  **Prérequis Base de Données :** Avoir un serveur PostgreSQL installé et accessible.
4.  **Création de la Base :** Créer une nouvelle base de données vide (par exemple, `banque_sae`).
5.  **Création de la Structure :** Exécuter le contenu du fichier `script_table_vues.sql` sur la base de données créée.
6.  **Chargement des Données :** Exécuter le contenu du fichier `alimentation_table.sql`. **Attention :** Ce script utilise la commande `COPY banque FROM ...`. Il faudra **impérativement** adapter le chemin `'chemin_vers_votre_fichier/sae_donnees_bancaires_nettoyee.csv'` pour qu'il pointe vers l'emplacement correct du fichier CSV sur le système où s'exécute le serveur PostgreSQL ou utiliser `\copy` avec `psql`.
7.  **Vérification :** Utiliser des requêtes `SELECT` pour vérifier que les données ont été correctement chargées et que les vues fonctionnent.
