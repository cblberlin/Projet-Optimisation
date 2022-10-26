% test for logiciel.m

x = [0;0];

h = [0.001; 0.002];

[Gfx, Gcx] = Gradient(x, @f1, 3, @c1, h);

lambda = ones(1, 2);



