function [x_etoile] = Ariane_newton(k, v_e, V_p, m_u)
% k: indice constructif
% v_e: Vitesse d'éjection
% V_p: Vitesse propulsive
% m_u: la masse du stellite

omega = k ./ (1 + k);

fct_h = @(x) (v_e(1) * log(1/omega(1) * (1 - v_e(3)/v_e(1)*(1 - omega(3)*x))) + ...
             (v_e(2) * log(1/omega(2) * (1 - v_e(3)/v_e(2)*(1 - omega(3)*x)))) + ...
              v_e(3) * log(x) - V_p);

h_prime = @(x) (omega(3) * v_e(3) / (1 - (v_e(3) * (1 - omega(3) * x)/v_e(2))) + ... 
                omega(3) * v_e(3) / (1 - (v_e(3) * (1 - omega(3) * x)/v_e(1))) + ...
                v_e(3) / x);

max_iter = 10000;

nb_iter = 0;

eps = 1e-10;

x = 3;

while (nb_iter < max_iter)
    x1 = x - fct_h(x)/h_prime(x);
    
    if(abs(x - x1) < eps || nb_iter > max_iter)
        break;
    end
    x = x1;
    nb_iter = nb_iter + 1;
end

x_etoile = x;

x2 = 1/omega(2) * (1 - v_e(3)/v_e(2) * (1 - omega(3) * x_etoile));

x1 = 1/omega(1) * (1 - v_e(2)/v_e(1) * (1 - omega(2) * x2));

X = [x1; x2; x_etoile];

J = ((1 + k(1))/X(1) - k(1)) * ((1 + k(2))/X(2) - k(2)) * ((1 + k(3))/X(3) - k(3));

M0 = m_u / J;

me_1 = M0 - M0/X(1);
me_2 = M0 - me_1 * (k(1) + 1) - (M0 - me_1 * (k(1) + 1))/X(2);
me_3 = M0 -  me_1 * (k(1) + 1) - me_2 * (k(2) + 1) - ...
      (M0 -  me_1 * (k(1) + 1) - me_2 * (k(2) + 1))/X(3);

fprintf("M0 = \n");
smart_print(M0);
fprintf("me = \n")
smart_print(me_1)
smart_print(me_2)
smart_print(me_3)

end