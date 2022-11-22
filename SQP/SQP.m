function [x_etoile, lambda_etoile] = SQP(x, lambda, max_iter, probleme, merite, bornes, rho, rho_max, eps, tau, choix)
%{
Entrées:
x: point initial de taille n* 1
lambda: point initial de taille 
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
% Bornes inf et sup
borne_inf = bornes(:,1);
borne_sup = bornes(:,2);
% indicateur pour le resultat de la globalisation
outcome = 0;

%------------------------------Algorithme SQP-----------------------------%
nb_iter = nb_iter + 1;
% calcul gradient par différence finie
[Grad_x, Grad_c] = Gradient(x, h, probleme);
% calcul du lagrangien
Grad_L = Gradient_Lagrangien(Grad_x, Grad_c, lambda);

% condition d'arret
% à compléter
arret = (nb_iter >= max_iter) | (norm(Grad_L) < eps);

while ~arret
    % Incrément le nombre d'itération
    nb_iter = nb_iter + 1;
    % à partir de la deuxième itération on approxime la Hessienne par
    % quasi-newton, en utilisant BFGS ou SRI
    if(outcome == 0)
        if(nb_iter > 2)
            % A partir de la deuxieme iteration on approxime la
            % hessienne par quasi-newton, en utilisant BFGS ou SRI
            H = quasi_newton(H, x, x_avant, Grad_L, Grad_L_avant, choix);
        end
        % modification hessienne pour qu'il soit definie positive
        H = modif_hess(H, tau);

        % Resoud le probleme quadratique
        [d_QP, lambda_QP] = res_quad(Grad_x, Grad_c, cx, H);
        
        % stocker les valeurs d'avant
        x_avant = x;
        fx_avant = fx;
        Grad_L_avant = Gradient_Lagrangien(Grad_x, Grad_c, lambda_QP);
    end

    % Globalisation pour ameliorer la descente
    [x, fx, cx, outcome] = globalisation(x, probleme, merite, fx, cx, Grad_x, d_QP, rho, borne_inf, borne_sup, outcome);

    if(outcome == 1)
        H = eye(n);
        outcome = 2;
        arret = (nb_iter >= max_iter);
        continue
    end

    if ((outcome == 2) && rho/2 <= rho_max)
        rho = 2 * rho;
        arret = (nb_iter >= max_iter);
        continue;
    end

    if (outcome == 0)
        [Grad_x, Grad_c] = Gradient(x, h, probleme);
        Grad_L = Gradient_Lagrangien(Grad_x, Grad_c, lambda_QP);
    end

    arret = (nb_iter >= max_iter) | (norm(Grad_L) < eps) | (norm(x - x_avant) < eps) | (abs(fx - fx_avant) < eps);
end

x_etoile = x;

lambda_etoile = lambda;

end