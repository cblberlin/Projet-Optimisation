function y_prime = ode_function(t, y, T_j, theta, q)
%{
Description:
    L'equation diff du modele
          R          V
    y' = [V] = [(T + W + D)/M]
          M         -q
T: poussee
W: poids
D: trainee

Entrees:
    t: temps
    y: un point materiel [R, V, M]
       R: Position, [x; y]
       V: Vitesse, [vx; vy]
       M: Masse, M
    T_j: poussée de l’étage j
    q: debit massique
Sortie:
    y_prime: 

%}
% constante gravitationnelle terrestre
mu = 3.986e+14;

% coefficient de trainée du lanceur
c_x = 0.1;

y_prime = zeros(5,1);

R_t = [y(1); y(2)];
V_t = [y(3); y(4)];
M_t = y(5);

R = norm(R_t, 2);
V = norm(V_t, 2);

% Poids
W = -mu * (R_t / R^3) * M_t;

% Trainee
D = -c_x * rho(R_t) * V * V_t;

% Vecteurs unitaires
e_r = 1 / R .* R_t;
e_h = 1 / R .* [-R_t(2); R_t(1)];

% pente de la vitesse
gamma = asind((R_t' * V_t) / (R * V));

% direction poussee
u_t = u(e_h, e_r, gamma, theta);

% Poussee
T = T_j * u_t;

% derivees
y_prime(1) = V_t(1);
y_prime(2) = V_t(2);
tmp = (T + W + D) / M_t;
y_prime(3) = tmp(1);
y_prime(4) = tmp(2);
y_prime(5) = -q;

end

