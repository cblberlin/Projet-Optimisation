function [R_tf, V_tf, y_1, y_2, y_3, t_1, t_2, t_3] = Simulateur_trajectoire(theta_0, theta, m_e, m_s, M, Mi, mu, c_x, R_terre, H_c, R_c, v_e, alpha)

%%%---------------------- CONDITIONS INITIALES -------------------------%%%

% temps
t_0 = 0;
% position
R_0 = [R_terre; 0];
% vitesse
V_0 = 100 * [cosd(theta_0); sind(theta_0)];
% masse
M_0 = M;

% condition initiale
y_0 = [R_0(1); R_0(2); V_0(1); V_0(2); M_0]; 

%%%----------------------- ALLUMAGE PAR ETAGE --------------------------%%%

% poussée de l'étage 1,2,3 (N)
T = alpha.*Mi; 
% Débit massique de l'étage 1,2,3
q = T ./ v_e;
% durée de combustion de l'étage 1,2,3
tc = m_e ./ q ;

% intervals pour l'intégration avec ode45
t_1 = tc(1);
t_2 = t_1 + tc(2);
t_3 = t_2 + tc(3);
tspan_1 = [t_0 t_1];
tspan_2 = [t_1 t_2];
tspan_3 = [t_2 t_3];

%%%------------------------- INTEGRATION -------------------------------%%%

%intégration 1
[t_1, y_1] = ode45(@(t,y) ode_fun(t, y, T(1), theta(1), q(1), mu, c_x), tspan_1, y_0);
% séparation 1
y_1(end, 5) = y_1(end, 5) - m_s(1); 

% intégration 2
[t_2, y_2] = ode45(@(t,y) ode_fun(t, y, T(2), theta(2), q(2), mu, c_x), tspan_2, y_1(end, :)); 
% séparation 2
y_2(end, 5) = y_2(end, 5) - m_s(2);

%intérgation 3
[t_3, y_3] = ode45(@(t,y) ode_fun(t, y, T(3), theta(3), q(3), mu, c_x), tspan_3, y_2(end, :)); 
% séparation 3
y_3(end, 5) = y_3(end, 5) - m_s(3);

%%%------------------------ RESULTATS FINAUX ---------------------------%%%

% POSITION FINALE
R_tf = [y_3(end, 1); y_3(end, 2)];
% VITESSE FINALE
V_tf = [y_3(end, 3); y_3(end, 4)];

end

