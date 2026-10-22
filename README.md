# Newton Fractal in Fortran 90

Ce projet implémente le calcul numérique des **bassins d'attraction de la méthode de Newton** pour la résolution de l'équation complexe $z^3 - 1 = 0$  en Fortran 90.

## Description mathématique
La méthode de Newton généralisée aux nombres complexes est définie par la relation récurrente :
$$z_{n+1} = z_n - \frac{z_n^3 - 1}{3z_n^2}$$

En explorant une grille rectangulaire du plan complexe, chaque point de départ est classé selon la racine vers laquelle il converge (parmi les 3 racines de l'unité) ou s'il diverge. Cela génère des structures fractales complexes et esthétiques.

## Fichiers du projet
- `Newtonfractal.f90` : Code source principal en Fortran 90.
- `*.dat` : Fichiers de sortie générés contenant les coordonnées $(x, y)$ pour chaque bassin d'attraction.

## Compilation et Exécution
Tu peux compiler et exécuter le code en utilisant un compilateur Fortran comme `gfortran` :

```bash
# Compilation
gfortran -O3 Newtonfractal.f90 -o newton_fractal

# Exécution
./newton_fractal
