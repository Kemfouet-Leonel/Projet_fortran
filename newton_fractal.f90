! ==============================================================================
! Programme pour générer les données de la fractale de Newton pour P(z) = z^3 - 1
! ==============================================================================
PROGRAM newton_fractal
  IMPLICIT NONE

  ! -- Déclaration des variables --
  ! Utilisation de double précision pour une meilleure justesse
  REAL(KIND=8) :: x0, y0, x, y, x_new, y_new
  REAL(KIND=8) :: num_x, num_y, den_x, den_y, norm_den
  REAL(KIND=8) :: dist1_sq, dist2_sq, dist3_sq
  REAL(KIND=8) :: xmin, xmax, ymin, ymax, dx, dy
  REAL(KIND=8), PARAMETER :: epsilon = 1.0E-6
  REAL(KIND=8), PARAMETER :: sqrt3_div_2 = 0.8660254037844386_8

  INTEGER :: i, j, n, nx, ny, max_iter
  INTEGER :: unit1, unit2, unit3, unit4
  LOGICAL :: has_converged

  ! -- Paramètres de la grille et de l'itération --
  xmin = -2.0_8
  xmax =  2.0_8
  ymin = -2.0_8
  ymax =  2.0_8
  nx = 800  ! Nombre de points en x (résolution)
  ny = 800  ! Nombre de points en y (résolution)
  max_iter = 50 ! Nombre maximum d'itérations

  dx = (xmax - xmin) / REAL(nx, 8)
  dy = (ymax - ymin) / REAL(ny, 8)

  ! -- Ouverture des fichiers de sortie --
  unit1 = 10; OPEN(unit1, FILE='root1.dat', STATUS='REPLACE')
  unit2 = 20; OPEN(unit2, FILE='root2.dat', STATUS='REPLACE')
  unit3 = 30; OPEN(unit3, FILE='root3.dat', STATUS='REPLACE')
  unit4 = 40; OPEN(unit4, FILE='diverge.dat', STATUS='REPLACE')

  WRITE(*,*) "Calcul en cours..."

  ! -- Boucle sur chaque pixel (point z0) de la grille --
  DO j = 0, ny
    y0 = ymin + j * dy
    DO i = 0, nx
      x0 = xmin + i * dx

      ! Initialisation de la suite de Newton
      x = x0
      y = y0
      has_converged = .FALSE.

      ! -- Itérations de Newton --
      DO n = 1, max_iter
        ! Calcul de z^2 et z^3
        ! z^2 = (x^2 - y^2) + i(2xy)
        ! z^3 = (x^3 - 3xy^2) + i(3x^2y - y^3)

        ! Calcul de z_n+1 = z_n - (z_n^3 - 1) / (3z_n^2)
        ! On utilise la forme simplifiée : z_n+1 = (2z_n^3 + 1) / (3z_n^2)

        ! Numérateur : 2*z^3 + 1
        num_x = 2.0_8 * (x**3 - 3.0_8 * x * y**2) + 1.0_8
        num_y = 2.0_8 * (3.0_8 * x**2 * y - y**3)

        ! Dénominateur : 3*z^2
        den_x = 3.0_8 * (x**2 - y**2)
        den_y = 3.0_8 * (2.0_8 * x * y)

        ! Norme (carrée) du dénominateur pour la division complexe
        norm_den = den_x**2 + den_y**2

        ! Sécurité pour éviter la division par zéro (près de z=0)
        IF (norm_den < 1.0E-12) THEN
          EXIT ! On considère que ça diverge
        END IF

        ! Division complexe : (num_x + i*num_y) / (den_x + i*den_y)
        x_new = (num_x * den_x + num_y * den_y) / norm_den
        y_new = (num_y * den_x - num_x * den_y) / norm_den

        x = x_new
        y = y_new

        ! -- Test de convergence vers une des trois racines --
        ! Racine 1: (1, 0)
        dist1_sq = (x - 1.0_8)**2 + y**2
        IF (dist1_sq < epsilon**2) THEN
          WRITE(unit1, *) x0, y0
          has_converged = .TRUE.
          EXIT
        END IF

        ! Racine 2: (-0.5, +sqrt(3)/2)
        dist2_sq = (x + 0.5_8)**2 + (y - sqrt3_div_2)**2
        IF (dist2_sq < epsilon**2) THEN
          WRITE(unit2, *) x0, y0
          has_converged = .TRUE.
          EXIT
        END IF

        ! Racine 3: (-0.5, -sqrt(3)/2)
        dist3_sq = (x + 0.5_8)**2 + (y + sqrt3_div_2)**2
        IF (dist3_sq < epsilon**2) THEN
          WRITE(unit3, *) x0, y0
          has_converged = .TRUE.
          EXIT
        END IF
      END DO

      ! -- Si aucune convergence après max_iter itérations --
      IF (.NOT. has_converged) THEN
        WRITE(unit4, *) x0, y0
      END IF

    END DO
  END DO

  ! -- Fermeture des fichiers --
  CLOSE(unit1)
  CLOSE(unit2)
  CLOSE(unit3)
  CLOSE(unit4)

  WRITE(*,*) "Calcul terminé. Les fichiers root1.dat, root2.dat, root3.dat et diverge.dat ont été créés."

END PROGRAM newton_fractal

