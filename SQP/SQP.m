function [x_all, fx_all, cx_all, lambda_all, Grad_L_norm_all, nb_iter, nb_eval, rho_all, nb_eval_all] = SQP(x, lambda, max_iter, max_eval, probleme, merite, bornes, rho, rho_max, eps, tau, choix)
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
% nombre d'appel de problème
nb_eval = 0;
% déterminer f(x) et c(x)
[fx, cx] = probleme(x);
% taille du vecteur d'entré
n = length(x);
% taille des contraintes d'égalités
m = length(cx);
% pas d'incrémentation pour la différence finie
h = repmat(1e-8, n, 1);
%h = h .* x;
% Initialisation pour la matrice Hessienne
H = eye(n);
% Bornes inf et sup
borne_inf = bornes(:,1);
borne_sup = bornes(:,2);
% indicateur pour le resultat de la globalisation
outcome = 0;
% Initiation du stokage des valeurs
x_all = [];
fx_all = [];
cx_all = [];
lambda_all = [];
Grad_L_norm_all = [];
rho_all = [];
nb_eval_all = [];

%------------------------------Algorithme SQP-----------------------------%
nb_iter = nb_iter + 1;
% calcul gradient par différence finie
[Grad_x, Grad_c] = Gradient(x, h, probleme);
nb_eval = nb_eval + 1;

% calcul gradient du lagrangien
Grad_L = Gradient_Lagrangien(Grad_x, Grad_c, lambda);

% condition d'arret
% à compléter
arret = (nb_iter >= max_iter) | (norm(Grad_L) < eps) | (nb_eval >= max_eval);
%sprintf("            nb évalutation | xk | f(xk) | c(xk) | lambda_k | norm(Grad_L)\n", nb_iter);
while ~arret
    %sprintf("Iter: %-g   | nb évalutation | xk | f(xk) | c(xk) | lambda_k | norm(Grad_L)\n", nb_iter);
    % Incrément le nombre d'itération
    nb_iter = nb_iter + 1;

    % stocker les valeur
    x_all = [x_all, x];
    lambda_all = [lambda_all, lambda];
    rho_all = [rho_all, rho];

    if(outcome == 0)
        if(nb_iter > 2)
            % A partir de la deuxieme iteration on approxime la
            % hessienne par quasi-newton, en utilisant BFGS ou SRI
            H = quasi_newton(H, x, x_avant, Grad_L, Grad_L_avant, choix);
        end
        % modification hessienne pour qu'il soit definie positive
        H = modif_hess(H, tau);

        % Resoud le probleme quadratique 
        [d_QP, lambda] = res_quad(Grad_x, Grad_c, cx, H);
        %smart_print(lambda_QP);
        
        % stocker les valeurs d'avant
        x_avant = x;
        fx_avant = fx;
        Grad_L_avant = Gradient_Lagrangien(Grad_x, Grad_c, lambda);
    end
    
    fx_all = [fx_all, fx];
    cx_all = [cx_all, cx];
    Grad_L_norm_all = [Grad_L_norm_all, norm(Grad_L)];

    % Globalisation pour ameliorer la descente
    [x, fx, cx, nb_eval_glob, outcome] = globalisation(x, probleme, merite, fx, cx, Grad_x, d_QP, rho, borne_inf, borne_sup, outcome);
    nb_eval = nb_eval + nb_eval_glob;
    nb_eval_all = [nb_eval_all, nb_eval];

    %fprintf("x_%i = \n", nb_iter);
    %smart_print(x);
    %fprintf("lambda = \n");
    %smart_print(lambda_QP);
    %fprintf("f(x_%i) = \n", nb_iter);
    %smart_print(fx);
    %fprintf("GLx = \n");
    %smart_print(Grad_L);

    if(outcome == 1)
        H = eye(n);
        %fprintf("hessien initialisés\n");
        outcome = 2;
        arret = (nb_iter >= max_iter) | (nb_eval >= max_eval);
        continue
    end

    if ((outcome == 2) && (rho/2 <= rho_max))
        rho = 2 * rho;
        %fprintf("\n\nOn augmente rho\n\n");
        arret = (nb_iter >= max_iter) | (nb_eval >= max_eval);
        continue;
    end

    if (outcome == 0)
        [Grad_x, Grad_c] = Gradient(x, h, probleme);
        nb_eval = nb_eval + n + 1;
        Grad_L = Gradient_Lagrangien(Grad_x, Grad_c, lambda);
    end

    arret = (nb_iter >= max_iter) | (nb_eval >= max_eval) |(norm(Grad_L) < eps) | (norm(x - x_avant) < eps) | (abs(fx - fx_avant) < eps);
    %fprintf("Iter: %i | nb évalutation | xk | f(xk) | c(xk) | lambda_k | norm(Grad_L)\n", nb_iter);
    %Format_output = 
    
end
%sprintf("Iter: %-g   | nb évalutation | xk | f(xk) | c(xk) | lambda_k | norm(Grad_L)\n", nb_iter);
x_all = [x_all, x];
lambda_all = [lambda_all, lambda];
rho_all = [rho_all, rho];
fx_all = [fx_all, fx];
cx_all = [cx_all, cx];
Grad_L_norm_all = [Grad_L_norm_all, norm(Grad_L)];
nb_eval_all = [nb_eval_all, nb_eval];

end