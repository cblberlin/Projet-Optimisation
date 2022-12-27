% add path
addpath("SQP");
addpath("Lanceur")

%%%----------Constantes------------%%%
% constante gravitationnelle terrestre
mu = 3.986e+14;

% coefficient de trainée du lanceur
c_x = 0.1; 

% rayon de la terre
R_terre = 6378137;

%%%----------Donnees du problem------------%%%
% Altitude cible
H_c = 250000;
% Charge utile
m_satelite = 1750;
% Rayon de l'orbite
R_c = R_terre + H_c;
% vitesse cible
V_c = sqrt(mu / R_c);
% indice constructif par etage
k = [0.1; 0.15; 0.2];
% vitesse d'ejection par etage
v_e = [2600; 3000; 4400];
% acceleration initiale
alpha = [15; 10; 10];

%%%----------Initialisation------------%%%
% vitesse propulsive
V_p = V_c;
% ecart entre la vitesse cible et la vitesse reelle
deltaV = 0.2*V_c;
% nombre d'iteration
nb_iter_total = 0;

%------Etagement init------%
% x_init
m_e_init = [15000; 13000; 5000];
% initialisationd de lambda
lambda_m_e_init = 0;
% bornes des masses des ergols
borne_m_e = [8000, 50000; 5000, 20000; 4000, 10000];

%------Trajectoire----%
% theta_init
theta_0 = 4.5; theta = [2; 6.5; 4];
THETA_init = [theta_0; theta];
% lambda init
lambda_THETA_init = [0; 0];
% borne_THETA
borne_THETA = [-90, 90; -90, 90; -90, 90; -90, 90];


nb_iter_total = nb_iter_total + 1;
%-------ETAGEMENT-------%
V_p = V_p + deltaV;
% pour que ariane soit une fonction d'une seule variable
Ariane6 = @(x) Ariane(x, V_p, m_satelite, k, v_e);
fprintf("Vitesse propulsive %f\n", V_p);

% Appel SQP
[m_e_all, f_all, ~, ~, ~, nb_iter, ~, ~, ~] = ...
SQP(m_e_init, lambda_m_e_init, 1000, 100000, Ariane6, @Fonc_merite, borne_m_e, 0.1, 1e4, 1e-5, 1e-5, "BFGS");
fprintf("Nombre d'iteration pb d'etagement : %d\n", nb_iter);

m_e_opt = m_e_all(:, end);
f_opt = f_all(end);
fprintf("masse optimales : [%f; %f; %f]\n", m_e_opt);

% masse seche
m_s = k .* m_e_opt;
% M est la masse initiale du lanceur et Mi est un vecteur de la
% masse du lanceur à l'allumage de l'étage 1,2 et 3 (kg) 
M = f_opt;
M_i = calcul_Mi(m_e_opt, m_satelite, k);

simulation_handle = @(THETA) simulation_trajectoire(THETA(1), [THETA(2); THETA(3); THETA(4)], m_e_opt, m_s, M, M_i, v_e, alpha);
branchement_handle = @(THETA) branchement(THETA, simulation_handle, R_c);
    
% Appel a SQP
[THETA_all, f_THETA_all, c_THETA_all, lambda_THETA_all, Grad_L_norm_THETA_all, nb_iter_THETA, nb_eval_THETA, rho_THETA_all, nb_eval_THETA_all] = ...
SQP(THETA_init, lambda_THETA_init, 1000, 100000, branchement_handle, @Fonc_merite, borne_THETA, 0.1, 1e3, 1e-5, 1e-5, "BFGS");

theta_opt = THETA_all(:, end);
fprintf("theta optimal = [%f; %f; %f; %f]\n", theta_opt);
    
% simulation de la trajectoire optimale
[R_tf, V_tf, y_1, y_2, y_3, t_1, t_2, t_3] = simulation_trajectoire(theta_opt(1), ... 
 [theta_opt(2); theta_opt(3); theta_opt(4)], m_e_opt, m_s, M, M_i, v_e, alpha);

deltaV = V_c - norm(V_tf);

fprintf("deltaV = %f\n", deltaV);
fprintf("norm(R_tf) - R_c = %f\n", norm(R_tf) - R_c);
fprintf("R_tf'*V_tf = %f\n", R_tf'*V_tf);

THETA_init = theta_opt;

tracees_simulation_trajectoire(y_1, y_2, y_3, t_1, t_2, t_3, R_terre, H_c, R_c, V_c);

