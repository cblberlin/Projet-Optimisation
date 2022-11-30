function xnew = projection_bornes(x, borne_inf, borne_sup)
%{
fprintf("x = \n");
smart_print(x);
fprintf("borne_inf = \n");
smart_print(borne_inf);
fprintf("borne_sup = \n");
smart_print(borne_sup);
%}
xnew = max(x, borne_inf);
xnew = min(xnew, borne_sup);

end

