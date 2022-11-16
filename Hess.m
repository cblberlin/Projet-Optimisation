function Hk = Hess(HK_1, xk, xk_1, GLx, GLx_1)
d_k_1 = xk - xk_1;

y_k_1 = GLx - GLx_1;

% BFGS
if (transpose(y_k_1) * d_k_1 > 0)
    Hk = HK_1 + (y_k_1 * transpose(y_k_1) / (transpose(y_k_1) * d_k_1)) - (HK_1 * d_k_1 * transpose(d_k_1) * HK_1)/(transpose(d_k_1) * HK_1 * d_k_1); 
else
    Hk = HK_1;
end

% SRI
if (abs(transpose(d_k_1) * (y_k_1 - HK_1 * d_k_1)) >= 1e-10)
    tmp = y_k_1 - HK_1 * d_k_1;
    Hk = tmp * transpose(tmp) / (transpose(d_k_1) * tmp);
else
    Hk = HK_1;
end

end

