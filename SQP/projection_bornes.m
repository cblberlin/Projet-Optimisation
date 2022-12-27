function xnew = projection_bornes(x, borne_inf, borne_sup)
%{
fprintf("x = \n");
smart_print(x);
fprintf("borne_inf = \n");
smart_print(borne_inf);
fprintf("borne_sup = \n");
smart_print(borne_sup);
%}
%eps = ones(size(borne_inf))*1e-8;

xnew = max(x, borne_inf);
xnew = min(xnew, borne_sup);

end

