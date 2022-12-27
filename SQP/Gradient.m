function [Gfx, Jcx] = Gradient(x, h, probleme)
%{
L'approximation du gradient fx et cx par différence finie

Input:
    x: vecteur, de taille n * 1
    h: vecteur incrément, de taille n * 1
    probleme: fonction(f(x) et c(x)) à calculer le gradient
              min f(x)
              s.c c(x) = 0
              f(x): R^n -> R
              c(x): R^n -> R^m

Output:
    Gfx: Gradient de f(x): de taille n * 1
    Jcx: Matrice Jacobienne de c(x): de taille n * m
%}

% pour ne pas avoir des erreurs en dimension

% calculer la valeur de f(x) et c(x)
[fx, cx] = probleme(x);

% déterminer le taille de n et m
n = length(x);
m = length(cx);

% Initialiser le résultat de Gfx et Gcx
Gfx = zeros(n, 1);
Jcx = zeros(n, m);
e = zeros(n);

for i = 1:n
    % calculer le gradient par différence finie
    e(i) = 1;
    [fx_h, cx_h] = probleme(x + h(i)*e);
    Gfx(i) = (fx_h - fx) / h(i);
    Jcx(i,:) = (cx_h - cx) / h(i);
    e(i) = 0;
end

end