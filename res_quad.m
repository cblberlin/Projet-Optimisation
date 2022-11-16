function [d_QP, lambda_QP] = res_quad(Grad_x, Grad_c, c, H)
%RES_QUAD Summary of this function goes here
%   Detailed explanation goes here

fprintf("le taille de gradient fx: %d * %d\n", size(Grad_x));
fprintf("le taille de gradient cx: %d * %d\n", size(Grad_c)); 
fprintf("le taille de gradient c: %d * %d\n", size(c)); 
fprintf("le taille de gradient H: %d * %d\n", size(H)); 

A = Grad_c;
Qinv = inv(H);
g = Grad_x';
b = -c;
fprintf("A = \n");
smart_print(A);
fprintf("Qinv = \n");
smart_print(Qinv);
fprintf("g = \n");
smart_print(g);
fprintf("b = \n");
smart_print(b);

lambda_QP = -inv(A * Qinv * A') * ((A * Qinv) * g + b);

d_QP = -Qinv * (A' * lambda_QP + g);

end

