function [Gfx, Gcx] = Gradient(x, func, m, func_con, h)

Gfx = zeros(size(x));

Gcx = zeros(length(x),m);

for i = 1:length(x)
    tmp = x;
    tmp(i) = tmp(i) + h(i);
    Gfx(i) = (func(tmp) - func(x)) / h(i);

    for j = 1:m
        tmp_c = x;
        tmp_c(i) = tmp_c(i) + h(i);
        cx_tmp = func_con(tmp_c);
        cx = func_con(x);
        Gcx(i,j) = (cx_tmp(j) - cx(j)) / h(i);
    end
end

end