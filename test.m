% test for logiciel.m

x = [0;0];

x_1 = x + h;

h = [0.001; 0.002];

[Gfx, Gcx] = Gradient(x, @f1, 1, @c1, h);

[Gfx_1, Gcx_1] = Gradient(x_1, @f1, 1, @c1, h);

lambda = ones(1, 1);

% Gradient de Lagragien par rapport à x
GLx_1 = Gfx_1 + Gcx_1 * lambda;

GLx =  Gfx + Gcx * lambda;

y_k_1 = GLx - GLx_1;

d_k_1 = x - x_1;

% test for Hessian BFGS

HK = Hessien_BFGS(eye(length(x)), x, x_1, GLx, GLx_1)

HK_1 = eye(2);

%Hk = HK_1 + (y_k_1 * transpose(y_k_1) / (transpose(y_k_1) * d_k_1)) - (HK_1 * d_k_1 * transpose(d_k_1) * HK_1)/(transpose(d_k_1) * HK_1 * d_k_1); 

