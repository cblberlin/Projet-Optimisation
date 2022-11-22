function H = quasi_newton(H, x, x_avant, Grad_L, Grad_L_avant, choix)

if choix == "BFGS"

    H = Hessien_BFGS(H, x, x_avant, Grad_L, Grad_L_avant);

elseif choix == "SRI"

    H = Hessien_SRI(H, x, x_avant, Grad_L, Grad_L_avant);

else

    fprintf("Erreur de choix");

    return
end