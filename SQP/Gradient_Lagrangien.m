function GLx = Gradient_Lagrangien(Gfx, Jcx, lambda)
%{
retourne le gradient de lagragien par rapport à x qui se sert à calculer
le hessien de lagragien dL(x)/dx^2, de taille n * 1

GLx(i) = Gfx(i) + lambda' * Jfx(:,i)

Input:
    Gfx: le gradient de f(x) de taille n * 1
    Jcx: La matrice jacobienne de c(x) de taille n * m
    lambda: multiplicateur lagragien de taille m * 1
Output:
    GLx: le gradient de lagragien par rapport à x de taille n * 1
%}
% Déterminer le taille n
% n = length(Gfx);

% Initialisation
GLx = Gfx + Jcx * lambda;
%smart_print(lambda)
%{
for i = 1:n
    %smart_print(Gfx(i));
    %fprintf("\n");
    %smart_print(lambda' * Jcx(:,i));
    GLx(i) = Gfx(i) + Jcx(i,:);
end
%}

end