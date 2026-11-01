# Intel MKL et Résolution d'Équations Numériques

##  Présentation

Ce projet explore l'utilisation de la bibliothèque **Intel Math Kernel Library (MKL)** pour résoudre efficacement des problèmes d'algèbre linéaire numérique. L'objectif est d'exploiter les optimisations matérielles proposées par Intel afin d'améliorer les performances des calculs matriciels et de la résolution de systèmes d'équations.

Les expérimentations sont réalisées en utilisant les modules **BLAS** et **LAPACK**, références standards pour le calcul scientifique haute performance.

---

##  Objectifs

- Comprendre l'architecture et les fonctionnalités de Intel MKL.
- Accélérer les calculs matriciels grâce aux routines optimisées BLAS.
- Résoudre efficacement des systèmes d'équations linéaires avec LAPACK.
- Comparer les performances des implémentations optimisées aux méthodes standards.
- Mettre en évidence l'intérêt du calcul haute performance dans les applications scientifiques.

---

##  Technologies utilisées

- Intel Math Kernel Library (MKL)
- C
- Python
- BLAS (Basic Linear Algebra Subprograms)
- LAPACK (Linear Algebra Package)

---

##  Fonctionnalités implémentées

### Opérations matricielles

- Multiplication de matrices
- Addition de matrices
- Calcul de normes matricielles
- Manipulation de vecteurs

### Résolution de systèmes linéaires

- Factorisation LU
- Résolution de systèmes \(Ax = b\)
- Inversion de matrices

### Analyse spectrale

- Calcul de valeurs propres
- Calcul de vecteurs propres
- Étude du comportement spectral des matrices

---

##  Résultats

Les expérimentations montrent que l'utilisation de **Intel MKL** permet :

- Une réduction significative du temps d'exécution des calculs matriciels.
- Une meilleure exploitation du parallélisme matériel.
- Une amélioration des performances grâce à la vectorisation SIMD et au multithreading.
- Une résolution plus efficace des systèmes de grande dimension.

---

##  Exécution

### Compilation (C)

```bash
gcc programme.c -lmkl_rt -o programme
./programme
```

### Python

```bash
python main.py
```

---

##  Références

- Intel Math Kernel Library Documentation
- BLAS (Basic Linear Algebra Subprograms)
- LAPACK Users' Guide
- Numerical Linear Algebra and Applications

---

Étudiant en Génie Mathématique et Modélisation (ENSGMM)
