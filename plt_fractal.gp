#Le Script Gnuplot

#Ce script va lire les quatre fichiers de données et tracer chaque ensemble de points avec une #couleur différente sur le même graphique.

#Enregistrez ce script dans un fichier nommé plot.gp :
#Extrait de code

# Script Gnuplot pour visualiser la fractale de Newton

# Configuration de la sortie (fichier PNG)
set terminal pngcairo size 800,800 enhanced font "Verdana,10"
set output 'fractale_newton_z3.png'

# Titres et labels
set title "Fractale de Newton pour P(z) = z^3 - 1"
set xlabel "Partie réelle (Re)"
set ylabel "Partie imaginaire (Im)"

# Configuration des axes et du style
set size square        # Assure un ratio 1:1 pour ne pas déformer le plan complexe
unset key              # Pas de légende
set palette model RGB defined (0 "red", 1 "green", 2 "blue", 3 "black") # Définir une palette
set cbrange [0:3]      # Spécifier la plage de la palette
unset colorbox         # Masquer la barre de couleur

# Commande de tracé
# Chaque fichier est tracé avec des points ('dots') et une couleur spécifique.
plot 'root1.dat' with dots lc "red" title "Converge vers 1", \
     'root2.dat' with dots lc "green" title "Converge vers -1/2 + i*sqrt(3)/2", \
     'root3.dat' with dots lc "blue" title "Converge vers -1/2 - i*sqrt(3)/2", \
     'diverge.dat' with dots lc "black" title "Diverge"

print "L'image 'fractale_newton_z3.png' a été générée."
