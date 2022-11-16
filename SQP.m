function [x_etoile, lambda_etoile] = SQP(x, lambda, max_iter, f, c, rho, eps)
%{
Entrées:
x, lambda: point initial
max_iter: le nombre maximal d'itération
f: fonction à minimiser
c: contraintes d'égalités
rho: pour le recherche linéaire
eps: pour encadrer le gradient de lagragien
%}


%------------------------------Initialisation-----------------------------%
% nombre d'itération
nb_iter = 0;
% taille du vecteur d'entré
n = length(x);
% taille des contraintes d'égalités
m = length(c(x));
% pas d'incrémentation pour la différence finie
h = repmat(1e-8, n, 1);
h = h .* x;
% Initialisation pour la matrice Hessienne
H = eye(n);

%------------------------------Algorithme SQP-----------------------------%
nb_iter = nb_iter + 1;
% déterminer f(x) et c(x)
fx = f(x);
cx = c(x);
% calcul gradient par différence finie
[Grad_x, Grad_c] = Gradient(x, f, c, m, h);
% calcul du lagrangien
Grad_L = Gradient_Lagrangien(Grad_x, Grad_c, lambda);

% condition d'arret
% à compléter
arret = (nb_iter >= max_iter) | norm(Grad_);

while ~arret
    % Incrément le nombre d'itération
    nb_iter = nb_iter + 1;
    % à partir de la deuxième itération on approxime la Hessienne par
    % quasi-newton, en utilisant BFGS ou SRI
    H = quasi_newton(H, x, x_avant, Grad_L, Grad_L_avant, choix);

    % modification hessien
    H = modif_hess(H, tau);

    % résoud le problème quadratique
    [d_QP, lambda] = res_quad(Grad_x, Grad_c, c, H);

    % Globalisation
    [x, f, c] = globalisation(x, f, c)

    % déplacement selon les cas différents
    
    
end