%{

% test for logiciel.m

x = [0;0];

h = [0.001; 0.002];

x_1 = x + h;

[Gfx, Gcx] = Gradient(x, @f1, 1, @c1, h);

[Gfx_1, Gcx_1] = Gradient(x_1, @f1, 1, @c1, h);

lambda = ones(1, 1);

% Gradient de Lagragien par rapport à x
GLx_1 = Gfx_1 + Gcx_1 * lambda;

GLx =  Gfx + Gcx * lambda;

y_k_1 = GLx - GLx_1;

d_k_1 = x - x_1;

% test for Hessian BFGS

HK = Hessien_SRI(eye(length(x)), x, x_1, GLx, GLx_1);

HK_1 = eye(2);

tau = 0.01;

Hk = HK_1 + (y_k_1 * transpose(y_k_1) / (transpose(y_k_1) * d_k_1)) - (HK_1 * d_k_1 * transpose(d_k_1) * HK_1)/(transpose(d_k_1) * HK_1 * d_k_1); 

H_prime = HK + tau * eye(length(x))

H_prime_ = chol(HK)

% test for def_pos

t = [1 0; 0 -2];


%}

x_init = [-1; 2; 1; -2; -2];

[f, c] = MHW4D(x_init);

m = length(c);

lambda_init = ones(1,m);

max_iter = 100;

rho = 0.001;

tau = 0.1;

eps = 0.0001;

[x_etoile, lambda_etoile] = SQP(x_init, lambda_init, max_iter, @MHW4D, rho, eps, tau, "BFGS");
