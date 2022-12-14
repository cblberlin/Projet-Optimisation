function y_prime = ode_fonction(t, y, Tj, theta, q, mu, c_x)

    y_prime = zeros(5,1);
    
    R_t = [y(1); y(2)];
    V_t = [y(3); y(4)];
    M_t = y(5);
    
    R = norm(R_t, 2);
    V = norm(V_t, 2);
    
    % ----------- Poids (Weight) (N) ------------------- %
    W_t =  - mu * (R_t / R^3) * M_t; % poids au moment t
    
    % ------------- Trainée (Drag) (N) ----------------- %
    D_t = -c_x * rho(R_t) * V * V_t; % trainee au moment t    
    % vecteurs unitaires er et eh
    er = 1 / R .* R_t;
    eh = 1 / R .* [-R_t(2); R_t(1)];
    % pente de la vitesse (attention au degrés et radians)
    % normalement on travaille avec des radians
    gamma = asind((R_t'* V_t) / (R*V) ) ;
    % direction de poussée
    u_t = u(eh, er, gamma, theta);
    
    % ------------ Poussée (Thrust) (N) --------------- %
    T_t = Tj * u_t; % poussée au moment t

    % ----------------- Les Dérivées ------------------ %
    y_prime(1) = V_t(1);
    y_prime(2) = V_t(2);
    tmp = (T_t + W_t + D_t) / M_t ;
    %fprintf("tmp = [%f; %f]\n", tmp);
    y_prime(3) = tmp(1);
    y_prime(4) = tmp(2);
    y_prime(5) = - q;
  
end
