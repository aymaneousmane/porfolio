# Méthodes QR et Davidson–Jacobi pour le Calcul des Valeurs Propres

##  Présentation

Le calcul des valeurs propres constitue un problème central en algèbre linéaire numérique et intervient dans de nombreux domaines tels que l'ingénierie, la physique, l'analyse vibratoire, le traitement du signal et l'apprentissage automatique.

Ce projet présente une étude comparative entre :

- la méthode QR, méthode de référence pour le calcul complet du spectre d'une matrice ;
- les méthodes Davidson et Jacobi-Davidson, particulièrement adaptées aux matrices de grande dimension lorsque seules quelques valeurs propres sont recherchées.

L'étude combine développements théoriques, analyse numérique et application réelle à un problème d'ingénierie aéronautique.

---

##  Objectifs

- Comprendre les principes du calcul numérique des valeurs propres.
- Étudier les différentes variantes de la décomposition QR.
- Analyser les performances des méthodes Davidson et Jacobi-Davidson.
- Comparer convergence, stabilité et coût de calcul.
- Appliquer ces méthodes à un problème pratique issu de l'aéronautique.

---

##  Concepts Mathématiques Étudiés

### Algèbre Linéaire

- Matrices orthogonales
- Matrices triangulaires
- Valeurs propres et vecteurs propres
- Quotient de Rayleigh
- Espaces de Krylov
- Approximation de Ritz

### Analyse Numérique

- Convergence des méthodes itératives
- Stabilité numérique
- Projection de Galerkin
- Préconditionnement

---

## 🔹 Méthode QR

### Décomposition QR

Étude des principales techniques utilisées pour obtenir la factorisation :

\[
A = QR
\]

où :

- \(Q\) est orthogonale ;
- \(R\) est triangulaire supérieure.

### Méthodes Implémentées

#### Gram-Schmidt

- Orthogonalisation des colonnes.
- Construction d'une base orthonormée.

#### Householder

- Réflexions orthogonales.
- Méthode la plus utilisée dans les bibliothèques scientifiques.

#### Givens

- Rotations planaires.
- Particulièrement adaptée aux matrices creuses.

### Algorithme QR

- Itération QR.
- Convergence vers la forme de Schur.
- Calcul de l'ensemble du spectre d'une matrice.

---

## 🔹 Méthode de Davidson

La méthode de Davidson vise à calculer efficacement les plus petites valeurs propres de grandes matrices symétriques.

### Principes

- Construction itérative d'un sous-espace d'approximation.
- Utilisation de l'approximation de Ritz.
- Préconditionnement diagonal.

### Points Forts

- Faible coût mémoire.
- Très efficace pour les matrices diagonalement dominantes.
- Calcul ciblé d'un petit nombre de valeurs propres.

---

## 🔹 Méthode de Jacobi-Davidson

Extension de la méthode de Davidson reposant sur la résolution d'une équation de correction orthogonale.

### Éléments Étudiés

- Correction orthogonale de Jacobi.
- Équation de correction de Jacobi-Davidson.
- Résolution approchée via GMRES et MINRES.
- Préconditionnement projeté.

### Avantages

- Très bonne précision.
- Convergence quadratique dans la phase finale.
- Adaptée aux problèmes de grande dimension.

---

##  Application : Analyse Vibratoire d'une Voilure d'Avion

### Contexte

La structure d'une aile d'avion est discrétisée en :

- 15 éléments finis ;
- matrice de rigidité symétrique tridiagonale ;
- problème aux valeurs propres :

\[
Hx=\lambda x
\]

### Objectif

Déterminer les plus petites valeurs propres associées aux fréquences propres de vibration.

### Résultats

Les trois premiers modes propres obtenus sont :

| Mode | Valeur propre |
|--------|--------|
| λ₁ | 0.01026135321621 |
| λ₂ | 0.09172148719990 |
| λ₃ | 0.25130676771084 |

### Interprétation Physique

- λ₁ : torsion globale de la voilure.
- λ₂ : flexion asymétrique.
- λ₃ : torsion des surfaces de contrôle.

Ces modes sont essentiels pour la détection précoce des phénomènes de résonance et de flutter.

---

## 📊 Comparaison des Méthodes

| Critère | Gram-Schmidt | Householder | Givens | Davidson | Jacobi-Davidson |
|----------|--------------|-------------|--------|-----------|-----------------|
| Stabilité | Moyenne | Très élevée | Très élevée | Élevée | Très élevée |
| Coût | Faible | Moyen | Élevé | Faible | Moyen |
| Grandes matrices | Limité | Bon | Bon | Excellent | Excellent |
| Valeurs propres ciblées | Non | Non | Non | Oui | Oui |

---

##  Technologies et Outils

- Python
- NumPy
- SciPy
- Algèbre Linéaire Numérique
- Méthodes de Krylov
- Éléments Finis
- Calcul Scientifique

---

## 📈 Résultats Principaux

- Implémentation et comparaison des méthodes QR, Davidson et Jacobi-Davidson.
- Étude des propriétés de convergence et de stabilité.
- Calcul précis des valeurs propres d'un problème d'ingénierie réel.
- Obtention de la plus petite valeur propre avec une précision de l'ordre de :

\[
2.6\times10^{-14}
\]

en seulement 9 itérations de Jacobi-Davidson.


Projet réalisé dans le cadre du cours **Analyse Numérique III** à l'École Nationale Supérieure de Génie Mathématique et Modélisation (ENSGMM), UniversitéNationale des Sciences, Technologies, Ingénierie et Mathématiques (UNSTIM).
