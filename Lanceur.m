%%% --------------------- LOGICIEL FINAL -------------------------------%%%

%%%------------------- CONSTANTES UTILISEES ----------------------------%%%

addpath("Lanceur");
addpath("SQP");

% contsante gravitationnelle terrestre (m^3/s^2)
mu = 3.986*1e14;
% coefficient de trainée du lanceur
c_x = 0.1;
% rayon terrestre 
R_terre = 6378137;

%%%----------------------- DONNEES DU PROBLEME -------------------------%%%

% hauteur cible
H_c = 250000;
% rayon de l'orbite
R_c = R_terre + H_c;
% vitesse cible sur l'orbite
V_c = sqrt(mu / R_c);
% masse du satelite 
m_satelite = 2000;
% indice constructif par étage
k = [0.10; 0.15; 0.20];
% vitesse d'ejection par étage (m/s)
v_e = [2600; 3000; 4400];
%acceleration initiale
alpha = [15; 10; 10]; 

%%%-------------------------- INITIALISATION ---------------------------%%%

% vitesse propulsive
V_p = V_c;
% écart entre la vitesse cible et la vitesse réelle
deltaV = 0.2*V_c;
% nombre d'itérations
nb_iter_total = 0;

% ------ ETAGEMENT ---------- % 

% bon x de départ pour SQP 
m_e_init = [15000; 13000; 5000];
% initialisation de lambda
lambda_m_e_init = 0;
% bornes des masses des ergols
bornes_m_e = [8000, 50000; 5000, 20000; 4000, 10000];

% ------ TRAJECTOIRE -------- %

% bon theta de départ pour SQP
theta_0 = 4.5; theta = [2; 6.5; 4];
THETA_init = [theta_0; theta];
%THETA_init = [20;15;20;5];
% initialisation de lambda
lambda_THETA_init = [0; 0];
% bornes de THETA
bornes_THETA = [-90, 90; -90, 90; -90, 90; -90, 90];

while 1
        nb_iter_total = nb_iter_total + 1;
    
    %-----------------------------ETAGEMENT-------------------------------%
        V_p = V_p + deltaV;
    
        % Handle pour que ariane soit une fonction d'une variable
        %ariane6 = @(x) Ariane(x, V_p, m_satelite, k, v_e);
        fprintf("Vitesse propulsive = %f\n", V_p);       
        
        % Appel à SQP 
        [x_all, f_all, c_all, lambda_all, grad_L_norm_all, nb_iter, nb_eval, rho_all] = SQP(m_e_init, lambda_m_e_init, 100,500, @Ariane, @Fonc_merite, bornes_m_e, 0.001, 10, 1e-6, 1e-3, 'BFGS');
        fprintf("Nb d'itérations pb d'étagement : %d\n", nb_iter);
        
        % Masses optimales
        m_e_opt = x_all(:,end);
        fprintf("masses optimales: [%f; %f; %f]\n", m_e_opt);
        
        % masse sèche 
        m_s = k.*m_e_opt;
        % M est la masse initiale du lanceur et Mi est un vecteur de la
        % masse du lanceur à l'allumage de l'étage 1,2 et 3 (kg) 
        [M, C] = Ariane(m_e_opt);
        
    %-----------------------------TRAJECTOIRE-----------------------------%
    %----------------------------(branchement)----------------------------%
        
        % handles pour que la simulation soit une fonction de THETA seulement
        % et de même pour le branchement
        simulation_handle = @(THETA) Simulateur_trajectoire(THETA(1), [THETA(2); THETA(3); THETA(4)], m_e_opt, m_s, M, C, mu, c_x, R_terre, H_c, R_c, v_e, alpha);
        branchement_handle = @(THETA) branchement(THETA, simulation_handle, R_c);
        
        % Appel à SQP

        fprintf("Nb d'itérations pb de trajectoire : %d\n", nb_iter_THETA);
        
        % Theta optimale
        theta_opt = THETA_all(:,end);
        fprintf("theta optimal = [%f; %f; %f; %f]\n", theta_opt);
        
        % simulation de la trajectoire optimale
        [R_tf, V_tf, y_1, y_2, y_3, t_1, t_2, t_3] = simulation_trajectoire(theta_opt(1), ...
            [theta_opt(2); theta_opt(3); theta_opt(4)], m_e_opt, m_s, M, C, mu, c_x, R_terre, H_c, R_c, v_e, alpha);
        
        % quelques tracées pour vérifier le résultat
        % tracees_simulation_trajectoire(y_1, y_2, y_3, t_1, t_2, t_3, R_terre, H_c, R_c, V_c);
    
    % mise à jour de deltaV    
    deltaV = V_c - norm(V_tf);
    
    fprintf("deltaV = %f\n", deltaV);
    fprintf("norm(R_tf) - R_c = %f\n", norm(R_tf) - R_c);
    fprintf("R_tf'*V_tf = %f\n", R_tf'*V_tf);
    THETA_init = theta_opt;
    %m_e_init = m_e_opt;
    
    if (abs(deltaV) < 1e-3 && (abs(R_tf'*V_tf) < 1e-3))
        break;
    end
end

tracees_simulation_trajectoire(y_1, y_2, y_3, t_1, t_2, t_3, R_terre, H_c, R_c, V_c);
fprintf("Nombre d'itérations au total : %d\n", nb_iter_total);
