function rho = rho(R_t)
% calcul de la densite de l'atmoshpere selon le modele exponentiel

% densite au sol
rho_0 = 1.225;

% facteur d'echelle
H = 7000;

% rayon de la terre
R_terre = 6378137;

rho = rho_0 * exp(-(norm(R_t, 2) - R_terre)/H);
end