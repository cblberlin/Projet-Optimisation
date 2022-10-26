function Hk = Hessien_BFGS(HK_1, xk, xk_1, GLx, GLx_1)

%H0 = eye(length(xk));

d_k_1 = xk - xk_1;

y_k_1 = GLx - GLx_1;

if (transpose(y_k_1) * d_k_1 > 0)
    Hk = HK_1 + (y_k_1 * transpose(y_k_1) / (transpose(y_k_1) * d_k_1)) - (HK_1 * d_k_1 * transpose(d_k_1) * HK_1)/(transpose(d_k_1) * HK_1 * d_k_1); 
else
    Hk = HK_1;
end

end