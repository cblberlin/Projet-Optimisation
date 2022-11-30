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
x_init = [-1;2;1;-2;-2];
lambda = ones(3,1);
max_iter = 1000;
max_eval = 1000;
rho = 0.001;
rho_max = 10;
eps = 0.001;
tau = 0.001;
choix = "BFGS";
bornes = [-2 0;
           1 3;
           0 2;
          -3 0;
          -3 -1];
[x_all, fx_all, cx_all, lambda_all, Grad_L_norm_all, nb_iter, nb_eval, rho_all, nb_eval_all] = SQP(x_init, lambda, max_iter, max_eval, @MHW4D, @Fonc_merite, bornes, rho, rho_max, eps, tau, choix);

x_etoile_ariane = x_all(:, end);
f_etoile = fx_all(end);
fprintf("x* = \n");
smart_print(x_etoile_ariane);
fprintf("f* = \n");
smart_print(f_etoile);

% Test SQP pour Ariane
x_init_ariane = 10000 * [1; 1; 1];
lambda_ariane = 1;
bornes_ariane = [0 150000;
                 0 40000;
                 0 8000];
[x_all_ariane, fx_all_ariane, cx_all_ariane, lambda_all_ariane, Grad_L_norm_all_ariane, nb_iter_ariane, nb_eval_ariane, rho_all_ariane, nb_eval_all_ariane] = SQP(x_init_ariane, lambda_ariane, max_iter, max_eval, @Ariane, @Fonc_merite, bornes_ariane, rho, rho_max, eps, tau, choix);
x_etoile_ariane = x_all_ariane(:, end);
f_etoile_ariane = fx_all_ariane(end);
fprintf("x* = \n");
smart_print(x_etoile_ariane);
fprintf("f* = \n");
smart_print(f_etoile_ariane);

