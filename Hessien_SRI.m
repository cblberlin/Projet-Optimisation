function Hk = Hessien_SRI(Hk_avant, xk, xk_avant, GLx, GLx_avant)
%{
Calculer la hessienne par quasi newton si d_{k-1}' * (y_{k-1} - H_{k-1} * d_{k-1) > 0 
sinon Hk ne change pas

Input:
    Hk_avant: la (k-1)-ième itération de hessienne de taille n * n
    xk: la k-ième itération de x
    xk_avant: la (k-1)-ième itération de x
    GLx: le k-ième itération de gradient de lagrangien par rapport à x de 
         taille n * 1
    GLx_avant: le k-ième itération de gradient de lagrangien par rapport à
         x de taille n * 1
Output:
    Hk: la k-ième itération de hessienne de taille n * n
%}

d_k_1 = xk - xk_avant;

y_k_1 = GLx - GLx_avant;

if (transpose(d_k_1) * (y_k_1 - Hk_avant * d_k_1) ~= 0)
    tmp = y_k_1 - Hk_avant * d_k_1;
    Hk = tmp * transpose(tmp) / (transpose(d_k_1) * tmp);
else
    Hk = Hk_avant;
end

end