addpath("SQP");
addpath("Lanceur")

% Test 1: calculer le gradient par différence finies
fprintf("Test pour le gradient\n");
x_init = [-1; 2];
h = repmat(1e-8, size(x_init));
[Gfx, Jcx] = Gradient(x_init, h, @func_simple);
fprintf("Gfx = \n");
smart_print(Gfx);
fprintf("Jcx = \n");
smart_print(Jcx);
%{
si le gradient de f est [2*x(1); 2*x(2)] et le gradient de c est [1 1], 
l'implémentation de gradient par différence finie est correcte
%}

% Test 2: calculer le Gradient de Lagrangien
lambda = ones(1, 1);
fprintf("\nTest pour le gradient de lagragien\n");
GLx = Gradient_Lagrangien(Gfx, Jcx, lambda);
fprintf("Le gradient de lagrangien par rapport à x = \n");
smart_print(GLx);

% Test 3: Hessien par quasi newton
x1 = x_init + h;
H = eye(length(x1));

%H_BFGS = Hessien_BFGS(H, x1, x_init, G)

% Test 4: res_quad


% Test SQP pour func_simple
%{
x_init = [-1;2];
lambda = 1;
max_iter = 10;
rho = 0.001;
rho_max = 10;
eps = 0.001;
tau = 0.001;
choix = "BFGS";
bornes = [-5 5;
          -5 5];
[x_etoile, lambda_etoile] = SQP(x_init, lambda, max_iter, @func_simple, @Fonc_merite, bornes, rho, rho_max, eps, tau, choix);

[f_etoile, ~] = func_simple(x_etoile);

fprintf("x* = \n");
smart_print(x_etoile);
fprintf("f* = \n");
smart_print(f_etoile);
%}


% Test SQP pour MHW4D
%{
x_init = [-1;2;1;-2;-2];
lambda = ones(3,1);
max_iter = 1000;
max_eval = 1000;
rho = 0.001;
rho_max = 10;
eps = 0.001;
tau = 0.001;
choix = "BFGS";
bornes = [-3 1;
           0 4;
           -1 3;
          -4 1;
          -4 0];
[x_all, fx_all, cx_all, lambda_all, Grad_L_norm_all, nb_iter, nb_eval, rho_all, nb_eval_all] = SQP(x_init, lambda, max_iter, max_eval, @MHW4D, @Fonc_merite, bornes, rho, rho_max, eps, tau, choix);

x_etoile_ariane = x_all(:, end);
f_etoile = fx_all(end);
fprintf("x* = \n");
smart_print(x_etoile_ariane);
fprintf("f(x*) = \n");
smart_print(f_etoile);

x_etoile_theorique = [-1.2366; 2.4616; 1.1911; -0.2144; -1.6165];
f_etoile_theorique = MHW4D(x_etoile_theorique);
fprintf("x = \n");
smart_print(x_etoile_theorique);
fprintf("f(x) = \n");
smart_print(f_etoile_theorique);
%}

test_MHW4D

% Test SQP pour Ariane
%test_Ariane

