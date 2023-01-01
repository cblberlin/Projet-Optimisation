fprintf("pour exemple d'Ariana1: \n");
k = [0.1101; 0.1532; 0.2154];
v_e = [2647.2; 2922.4; 4344.3];
V_p = 11527;
m_u = 1700;

Ariane_newton(k, v_e, V_p, m_u);

fprintf("pour la partie lanceur: \n");
k2 = [0.1; 0.15; 0.2];
v_e2 = [2600; 3000; 4400];
V_p2 = sqrt(3.986e+14/(6378137 + 250000));
m_u2 = 1750;

Ariane_newton(k2, v_e2, V_p2, m_u2);