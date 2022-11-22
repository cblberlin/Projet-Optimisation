function xnew = projection_bornes(x, borne_inf, borne_sup)

xnew = max(x, borne_inf);
xnew = min(xnew, borne_sup);

end

