function print_result(nb_iter, nb_eval_all, x_all, fx_all, cx_all, lambda_all, Grad_L_norm_all)

[n, ~] = size(x_all);

[m, ~] = size(cx_all);
%% mise en forme pour tout les vectuer
fprintf(" Iter |  nfonc | "); 
fprintf("%*s", 11 * fix(n/2) , 'x'); 
fprintf("%*s", 11 * fix(n/2), " ");
fprintf( "|   f(x)   |");
fprintf("%*s", 17 * fix(m/2) , 'c(x)'); 
fprintf("%*s", 13 * fix(m/2), " ");
fprintf("|          lambda         |  Grad_L\n");
for i = 1:nb_iter
    F = ['%5d |%7d', ' |',repmat('%8.4f ', 1, n), '| ','%8.4f', ' |',repmat(' %8.4f ', 1, m),'| ',repmat('%8.4f',1, m), '| ', ' %8.4f' ,'\n'];
    fprintf(F, i, nb_eval_all(i), x_all(:,i), fx_all(i), cx_all(:,i), lambda_all(:,i), Grad_L_norm_all(i));
    %F = ['%d', '%d', repmat(' %8.4f',1 , n), '%8.4f', repmat(' %8.4f', 1, m), repmat(' %8.4f', 1, m), '%8.4f', "\n"];
    %fprintf(F, i, nb_eval_all(i).', x_all(i).', fx_all(i), cx_all(i).', lambda_all(i).', Grad_L_norm_all(i));
end

end

