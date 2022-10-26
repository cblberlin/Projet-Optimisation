function Hk = Hessien_SRI(HK_1, xk, xk_1, GLx, GLx_1)

%H0 = eye(length(xk));



d_k_1 = xk - xk_1;

y_k_1 = GLx - GLx_1;

if (transpose(d_k_1) * (y_k_1 - HK_1 * d_k_1) ~= 0)
    tmp = y_k_1 - HK_1 * d_k_1;
    Hk = tmp * transpose(tmp) / (transpose(d_k_1) * tmp);
else
    Hk = HK_1;
end

end