# Modélisation d’une Épidémie dans un Campus Universitaire

##  Présentation

Ce projet a pour objectif de modéliser la propagation d’une épidémie dans un campus universitaire composé de plusieurs bâtiments interconnectés.

Le modèle repose sur une extension spatiale du modèle SIR (Susceptibles - Infectés - Rétablis), permettant de prendre en compte non seulement la dynamique épidémique locale au sein de chaque bâtiment, mais aussi les déplacements des individus entre bâtiments.

L’étude combine modélisation mathématique, méthodes numériques et analyse de stabilité afin de simuler différents scénarios de propagation et d’intervention sanitaire.

---

##  Objectifs

- Modéliser la propagation d'une épidémie dans un environnement structuré.
- Étudier l'effet des déplacements sur la diffusion de la maladie.
- Implémenter plusieurs méthodes numériques de résolution.
- Comparer précision, stabilité et convergence des méthodes.
- Simuler l’impact de mesures sanitaires ciblées.

---

##  Modèle Mathématique

Le projet utilise un modèle SIR spatial :

\[
\frac{dS_i}{dt}=-\beta\frac{S_iI_i}{N_i}+D_S\nabla^2S_i
\]

\[
\frac{dI_i}{dt}=\beta\frac{S_iI_i}{N_i}-\gamma I_i+D_I\nabla^2I_i
\]

\[
\frac{dR_i}{dt}=\gamma I_i+D_R\nabla^2R_i
\]

où :

- \(S_i\) : population susceptible
- \(I_i\) : population infectée
- \(R_i\) : population rétablie
- \(\beta\) : taux de transmission
- \(\gamma\) : taux de guérison
- \(D_S, D_I, D_R\) : coefficients de diffusion

La diffusion spatiale est modélisée par un Laplacien discret sur un graphe représentant les bâtiments.

---

##  Technologies Utilisées

- Python
- NumPy
- Matplotlib
- IPyWidgets
- Analyse numérique
- Équations différentielles
- Modélisation mathématique

---

##  Méthodes Numériques Implémentées

### Euler Explicite

- Schéma simple et rapide à implémenter
- Faible coût de calcul
- Sensible aux contraintes de stabilité

### Euler Implicite

- Schéma plus robuste
- Résolution par itérations de point fixe
- Stabilité améliorée

### Runge-Kutta d’Ordre 4 (RK4)

- Très bonne précision
- Référence utilisée pour l’analyse des erreurs
- Compromis efficace entre coût et performance

---

##  Analyse de Stabilité

Le projet établit la condition CFL assurant la stabilité numérique du système couplé :

\[
\Delta t \leq \min\left(\frac{2}{\beta+\gamma},\frac{\Delta x^2}{2D}\right)
\]

Cette condition permet de garantir la cohérence des simulations temporelles et spatiales.

---

##  Analyse de Convergence

Les solutions obtenues par Euler implicite sont comparées à celles de RK4 au moyen de l’erreur L₂ :

\[
Erreur_{L2}
=
\sqrt{\Delta t \sum (u_i-v_i)^2}
\]

Cette étude permet d’évaluer la précision des schémas numériques pour différents pas de temps et pas spatiaux.

---

##  Scénarios Sanitaires Simulés

### Cours en Présentiel

- Augmentation locale du taux de transmission.
- Simulation des zones à forte densité d’étudiants.

### Confinement Localisé

- Suppression de la diffusion entre bâtiments.
- Étude de l’impact de l’isolement d’un bâtiment contaminé.

### Stratégies Adaptatives

- Ajustement dynamique des paramètres.
- Déclenchement automatique de mesures sanitaires selon des seuils d’alerte.

---


##  Résultats

- Simulation de la propagation d'une épidémie sur un réseau de 20 bâtiments.
- Comparaison des performances des méthodes Euler explicite, Euler implicite et RK4.
- Validation numérique des schémas par analyse de stabilité et de convergence.
- Évaluation de différentes stratégies de contrôle épidémique.

