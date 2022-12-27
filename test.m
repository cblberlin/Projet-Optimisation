addpath("SQP");
addpath("Lanceur")

% Test 1: calculer le gradient par différence finies
fprintf("Test pour le gradient\n");
x_init = [-1; 2];
h = repmat(1e-8, size(x_init));
[Gfx, Jcx] = Gradient(x_init, h, @func_simple);
fprintf("Gfx = \n");
smart_print(Gfx);
fprintf("Jcx = \n");
smart_print(Jcx);
%{
si le gradient de f est [2*x(1); 2*x(2)] et le gradient de c est [1 1], 
l'implémentation de gradient par différence finie est correcte
%}

% Test 2: calculer le Gradient de Lagrangien
lambda = ones(1, 1);
fprintf("\nTest pour le gradient de lagragien\n");
GLx = Gradient_Lagrangien(Gfx, Jcx, lambda);
fprintf("Le gradient de lagrangien par rapport à x = \n");
smart_print(GLx);

% Test 3: Hessien par quasi newton
x1 = x_init + h;
H = eye(length(x1));

% Test 4:

test_MHW4D

% Test 5: SQP pour Ariane
test_Ariane

