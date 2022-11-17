function Hk = Hessien_BFGS(Hk_avant, xk, xk_avant, GLx, GLx_avant)
%{
Calculer la hessienne par quasi newton si y_{k-1}' * d_{k-1} > 0 sinon Hk
ne change pas

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

dk_avant = xk - xk_avant;

yk_avant = GLx - GLx_avant;

if (transpose(yk_avant) * dk_avant > 0)
    Hk = Hk_avant + (yk_avant * transpose(yk_avant) / (transpose(yk_avant) * dk_avant)) - (Hk_avant * dk_avant * transpose(dk_avant) * Hk_avant)/(transpose(dk_avant) * Hk_avant * dk_avant); 
else
    Hk = Hk_avant;
end

end