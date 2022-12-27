function [R_tf, V_tf, y_1, y_2, y_3, t_1, t_2, t_3] = ...
simulation_trajectoire(theta_0, theta, m_e, m_s, M, M_i, v_e, alpha)
R_terre = 6378137;
% temps
t_0 = 0;
% Position
R_0 = [R_terre; 0];
% Vitesse
V_0 = 100 * [cosd(theta_0); sind(theta_0)];
% Masse
M_0 = M;
% condition init
y_0 = [R_0(1); R_0(2); V_0(1); V_0(2); M_0];

% ----------Allumage par etage
T = alpha.*M_i;
% Debit massique de l'etage 1,2,3
q = T ./ v_e;
% duree de combustion de l'etage 1,2,3
tc = m_e ./ q;

% intervals pour l'integration avec ode45
t_1 = tc(1);
t_2 = t_1 + tc(2);
t_3 = t_2 + tc(3);
tspan_1 = [t_0 t_1];
tspan_2 = [t_1 t_2];
tspan_3 = [t_2 t_3];

%---------Integration
% Integration 1
[t_1, y_1] = ode45(@(t, y) ode_function(t, y, T(1), theta(1), q(1)), tspan_1, y_0);
% separation 1
y_1(end, 5) = y_1(end, 5) - m_s(1);

% Integration 2
[t_2, y_2] = ode45(@(t, y) ode_function(t, y, T(2), theta(2), q(2)), tspan_2, y_1(end, :));
% separation 2
y_2(end, 5) = y_2(end, 5) - m_s(2);

% Integration 3
[t_3, y_3] = ode45(@(t, y) ode_function(t, y, T(3), theta(3), q(3)), tspan_3, y_2(end, :));
% separation 3
y_3(end, 5) = y_3(end, 5) - m_s(3);

% Position finale
R_tf = [y_3(end, 1); y_3(end, 2)];
% Vitesse finale
V_tf = [y_3(end, 3); y_3(end, 4)];
end