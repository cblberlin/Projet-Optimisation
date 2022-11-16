function [x_opt, fx_next, cx_next] = globalisation(x, probleme, merite, fx, cx, Grad_x, d_QP, rho)

s = 1;

c1 = 0.1;

F_x = merite(fx, cx, rho);

armijo = false;

x_opt = x;

fx_next = fx; cx_next = cx;

derivee_direction = Grad_x' + d_QP - rho * norm(cx, 1);

if derivee_direction < 0

while s > 1e-6
    xsd = x + s*d_QP;
    [fx_xsd, cx_xsd] = probleme(xsd);
    F_xsd = merite(f_xsd, c_xsd, rho);
    if F_xsd < F_x + c1*s*derivee_direction
        armijo = true;
        break;
    end
    s = s/2;
    
end

if armijo 

    x_opt = xsd;
    fx_next = fx_xsd;
    cx_next = cx_xsd;

end

end

end

