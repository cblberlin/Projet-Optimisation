function [Gfx, Gcx] = Gradient(x, func, m, func_con, h)

Gfx = zeros(size(x));

Gcx = zeros(length(x),m);
tmp_x = func(x);
tmp_cx = func_con(x);

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

end