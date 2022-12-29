fct_h = @(x) (2647.2 * log(-6.4619 + 2.931 * x) + ...
              2922.4 * log(-3.6622 + 1.9828 * x) + ...
              4344.3 * log(x) - 11527);

h_prime = @(x) ((5569.6 * x) / (x^2 - 4.05166 * x + 4.072) + 4344.3 / x);

max_iter = 100;

nb_iter = 0;

eps = 1e-10;

x = 3;

while (nb_iter < max_iter)
    x1 = x - fct_h(x)/h_prime(x);
    if(abs(x - x1) < eps)
        break;
    end
    x = x1;
    nb_iter = nb_iter + 1;
end

X = [10.0826 * (1 - 1.1039 * (1 - 0.13284 * 2.9376)); 
    7.5278 * (1 - 1.4865 * (1 - 0.17722 * 3.3281));
    x];

J = (1.1101/X(1) - 0.1101) * (1.1532/X(2) - 0.1532) * (1.2154/X(3) - 0.2154);

M0 = 1700 / J;

me_1 = M0 - M0/X(1);
me_2 = M0 - me_1 * (0.1101 + 1) - (M0 - me_1 * (0.1101 + 1))/X(2);
me_3 = M0 -  me_1 * (0.1101 + 1) - me_2 * (0.1532 + 1) - ...
      (M0 -  me_1 * (0.1101 + 1) - me_2 * (0.1532 + 1))/X(3);

fprintf("M0 = \n");
smart_print(M0);
fprintf("me = \n")
smart_print(me_1)
smart_print(me_2)
smart_print(me_3)
