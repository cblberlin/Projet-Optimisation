function [f, c] = branchement(THETA, simulation, R_c)

[R_tf, V_tf, ~, ~, ~, ~, ~, ~] = simulation(THETA);

f = -norm(V_tf,2); 
c1 = norm(R_tf,2) - R_c; 
c2 =  R_tf'*V_tf; 
c = [c1;c2]; 

end