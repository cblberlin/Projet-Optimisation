function u = u(e_h, e_r, gamma, theta)
%{

Entrees:
    e_h: vecteur unitaire horizontal
    e_r: vecteur unitaire vertical
    gamma: l'angle entre vecteur horizontal et la vitesse
    theta: l'angle entre la direction poussee et la vitesse
Sortie:
    u: la direction poussee
%}

% cosd(x), x exprime en radian
u = e_h*cosd(gamma + theta) + e_r*sind(gamma + theta);

end