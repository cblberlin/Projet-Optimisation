x_init_ariane = [250000;100000;50000];
lambda_ariane = 1;
bornes_ariane = [140000 200000000;
                 20000 100000000;
                 5000 5000000];
[x_all_ariane, fx_all_ariane, cx_all_ariane, lambda_all_ariane, Grad_L_norm_all_ariane, nb_iter_ariane, nb_eval_ariane, rho_all_ariane, nb_eval_all_ariane] = SQP(x_init_ariane, lambda_ariane, max_iter, max_eval, @Ariane, @Fonc_merite, bornes_ariane, rho, rho_max, eps, tau, choix);
x_etoile_ariane = x_all_ariane(:, end);
f_etoile_ariane = fx_all_ariane(end);
fprintf("\nm* = \n");
smart_print(x_etoile_ariane);
fprintf("M* = \n");
smart_print(f_etoile_ariane);
x_etoile_ariane_theorique = [145349; 31215; 7933];
f_etoile_ariane_theorique = Ariane(x_etoile_ariane_theorique);
fprintf("\nm = \n");
smart_print(x_etoile_ariane_theorique);
fprintf("M = \n");
smart_print(f_etoile_ariane_theorique);
print_result(nb_iter_ariane, nb_eval_all_ariane, x_all_ariane, fx_all_ariane, cx_all_ariane, lambda_all_ariane, Grad_L_norm_all_ariane)