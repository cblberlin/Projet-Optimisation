x_init = [-1;2;1;-2;-2];
lambda = ones(3,1);
max_iter = 1000;
max_eval = 1000;
rho = 1e-3;
rho_max = 1e7;
eps = 0.001;
tau = 0.001;
choix = "BFGS";
bornes = [-3 1;
           0 4;
           -1 3;
          -4 1;
          -4 0];
[x_all, fx_all, cx_all, lambda_all, Grad_L_norm_all, nb_iter, nb_eval, rho_all, nb_eval_all] = ...
SQP(x_init, lambda, max_iter, max_eval, @MHW4D, @Fonc_merite, bornes, rho, rho_max, eps, tau, choix);

x_etoile = x_all(:, end);
f_etoile = fx_all(end);
fprintf("\nx* = \n");
smart_print(x_etoile);
fprintf("f(x*) = \n");
smart_print(f_etoile);

x_etoile_theorique = [-1.2366; 2.4616; 1.1911; -0.2144; -1.6165];
f_etoile_theorique = MHW4D(x_etoile_theorique);
fprintf("\nx = \n");
smart_print(x_etoile_theorique);
fprintf("f(x) = \n");
smart_print(f_etoile_theorique);
print_result(nb_iter, nb_eval_all, x_all, fx_all, cx_all, lambda_all, Grad_L_norm_all);