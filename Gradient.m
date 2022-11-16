function [Gfx, Gcx] = Gradient(x, h, probleme)
%{
Gfx = zeros(size(x));

Gcx = zeros(length(x),m);
tmp_x = fx;
tmp_cx = cx;

for i = 1:length(x)
    tmp = x;
    tmp(i) = tmp(i) + h(i);
    Gfx(i) = (func(tmp) - tmp_x) / h(i);

    for j = 1:m
        tmp_c = x;
        tmp_c(i) = tmp_c(i) + h(i);
        cx_tmp = func_con(tmp_c);
        Gcx(i,j) = (cx_tmp(j) - tmp_cx(j)) / h(i);
    end
end
%}

[fx, cx] = probleme(x);

[fx_h, cx_h] = probleme(x + h);

n = length(x);
m = length(cx);

Gfx = zeros(n, 1);
Gcx = zeros(m, n);

for i = 1:length(x)
    Gfx(i) = (fx_h - fx) / h(i);
    Gcx(:,i) = (cx_h - cx) / h(i);
end
end