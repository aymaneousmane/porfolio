# Normalisation et Optimisation des Bases de Données : impact sur la cohérence et les performances

##  Présentation

Ce projet étudie les principes fondamentaux de conception des bases de données relationnelles en mettant l’accent sur deux aspects essentiels :

- la cohérence des données à travers la normalisation ;
- l’optimisation des performances grâce aux mécanismes d’indexation et d’intégrité référentielle.

L’objectif est de comprendre comment construire des bases de données robustes, évolutives et performantes tout en garantissant la qualité de l’information stockée.

---

##  Objectifs

- Réduire la redondance des données.
- Éliminer les anomalies d'insertion, de mise à jour et de suppression.
- Garantir l'intégrité et la cohérence des informations.
- Optimiser les temps de réponse des requêtes.
- Concevoir des schémas relationnels fiables et évolutifs.

---

##  Concepts Étudiés

### Normalisation des Bases de Données

Le projet présente les différentes formes normales utilisées dans la conception des bases de données :

#### Première Forme Normale (1NF)

- Valeurs atomiques.
- Suppression des groupes répétitifs.
- Unicité des lignes.

#### Deuxième Forme Normale (2NF)

- Élimination des dépendances partielles.
- Décomposition des tables à clé composite.

#### Troisième Forme Normale (3NF)

- Suppression des dépendances transitives.
- Amélioration de la cohérence du modèle relationnel.

#### Formes Normales Supérieures

- BCNF
- 4NF
- 5NF

---

##  Assurance de la Cohérence

### Intégrité Référentielle

Mise en œuvre des mécanismes permettant de garantir la cohérence entre les tables :

- Clés primaires (Primary Keys)
- Clés étrangères (Foreign Keys)
- Contraintes de référence

Actions étudiées :

- ON DELETE CASCADE
- ON DELETE RESTRICT
- ON DELETE SET NULL
- ON DELETE SET DEFAULT

---

##  Optimisation des Performances

### Indexation

Étude des structures permettant d'accélérer l'accès aux données :

- Index simples
- Index composites
- Index uniques
- Index sur clés étrangères
- Index Full-Text

### Optimisation des Requêtes

Analyse des performances des opérations :

- SELECT
- JOIN
- WHERE
- ORDER BY
- GROUP BY

---

##  Technologies et Outils

- SQL
- Systèmes de Gestion de Bases de Données (SGBD)
- Modélisation relationnelle
- Diagrammes Entité-Association
- Jupyter Notebook (cas pratique)

---

##  Résultats

L'étude met en évidence que :

- La normalisation améliore significativement la cohérence des données.
- L’intégrité référentielle réduit les incohérences et les données orphelines.
- Une indexation adaptée diminue fortement les temps d'exécution des requêtes.
- Un équilibre entre normalisation et optimisation est nécessaire pour obtenir une base de données à la fois fiable et performante.

---

et Mathématiques (UNSTIM), dans le cadre du cours **Analyse et Bases de Données**.
