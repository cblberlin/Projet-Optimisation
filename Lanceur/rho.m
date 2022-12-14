function rho = rho(R_t)
%%% calcul de la densité de l'atmosphère selon le modèle
%%% exponentiel

    rho_0 = 1.225; % densité au sol (kg/m^3)    
    H = 7000; % facteur d'échelle (m)
    R_terre = 6378137; % rayon terrestre 
    
    % denisté de l'atmosphère (kg/m^3):
    rho = rho_0 * exp(-(norm(R_t,2) - R_terre)/H);
end