function [d_QP, lambda_QP] = res_quad(Grad_x, Grad_c, c, H)
%{
Résoud le système 
min 1/2 d_QP' * Hess_L * d_QP + Gfx' * d_QP
s.c Gcx' * d_QP + c = 0

le système se transforme si Hess_L est définie positive
[Hess_L Gfx' * [d_QP      = -[Gfx + Gcx' * lambda_QP
 Gfx    0  ]   lambda_QP]     c                     ]

Input: 
    Grad_x: Le gradient de f(xk) de taille n * 1
    Grad_c: La matrice jacobienne de c(xk) de taille m * n
    c: La valeur de c(xk)
    H: La matrice Hessienne de Lagrangien
Output:
    d_QP: la solution de système
    lambda_QP: la solution de système
%}

A = Grad_c';
Qinv = inv(H);
g = Grad_x;
b = -c;

fprintf("le taille de A: %d * %d\n", size(A));
fprintf("le taille de Qinv: %d * %d\n", size(Qinv)); 
fprintf("le taille de g: %d * %d\n", size(g)); 
fprintf("le taille de b: %d * %d\n", size(b)); 
%{
fprintf("A = \n");
smart_print(A);
fprintf("Qinv = \n");
smart_print(Qinv);
fprintf("g = \n");
smart_print(g);
fprintf("b = \n");
smart_print(b);
%}
lambda_QP = -inv(A * Qinv * A') * ((A * Qinv) * g + b);

d_QP = -Qinv * (A' * lambda_QP + g);

end

