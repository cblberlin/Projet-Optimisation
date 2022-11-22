function [f, c] = func_simple(x)
%{
fonction simple pour valider le logiciel
min x1^2 + x2^2
s.c x1 + x2 - 1 = 0

Input:
    x: vecteur de taille 2 * 1
Output:
    f: nombre réel
    c: nombre réel
%}
f = x(1)^2 + x(2)^2;
c = x(1) + x(2) - 1;
end

