function [x_etoile, lambda_etoile] = SQP(x, lambda, max_iter, probleme, rho, eps, tau, choix)
%{
Entrées:
x, lambda: point initial
max_iter: le nombre maximal d'itération
probleme: retourne le f(x) et c(x)
rho: pour le recherche linéaire
eps: pour encadrer le gradient de lagragien
%}


%------------------------------Initialisation-----------------------------%
% nombre d'itération
nb_iter = 0;
% déterminer f(x) et c(x)
[fx, cx] = probleme(x);
% taille du vecteur d'entré
n = length(x);
% taille des contraintes d'égalités
m = length(cx);
% pas d'incrémentation pour la différence finie
h = repmat(1e-8, n, 1);
h = h .* x;
% Initialisation pour la matrice Hessienne
H = eye(n);

%------------------------------Algorithme SQP-----------------------------%
nb_iter = nb_iter + 1;
% calcul gradient par différence finie
[Grad_x, Grad_c] = Gradient(x, h, probleme);
% calcul du lagrangien
Grad_L = Gradient_Lagrangien(Grad_x, Grad_c, lambda);

% condition d'arret
% à compléter
arret = (nb_iter >= max_iter);

while ~arret
    % Incrément le nombre d'itération
    nb_iter = nb_iter + 1;
    % à partir de la deuxième itération on approxime la Hessienne par
    % quasi-newton, en utilisant BFGS ou SRI
    if nb_iter > 2
        H = quasi_newton(H, x, x_avant, Grad_L, Grad_L_avant, choix);
    end
    x_avant = x;
    fx_avant = fx;
    Grad_L_avant = Gradient_Lagrangien(Grad_x, Grad_c, lambda);
    % modification hessien
    H = modif_hess(H, tau);

    % résoud le problème quadratique
    [d_QP, lambda_QP] = res_quad(Grad_x, Grad_c, cx, H);

    % Globalisation
    %[x_opt, fx_next, cx_next] = globalisation(x, probleme, merite, fx, cx, Grad_x, d_QP, borne_inf, borne_sup, rho);

    % déplacement selon les cas différents
    x = x + d_QP;
    lambda = lambda + lambda_QP;
    
end

x_etoile = x;

lambda_etoile = lambda;