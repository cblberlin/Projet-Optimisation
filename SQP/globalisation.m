function [x_opt, fx_next, cx_next, nb_eval, outcome] = globalisation(x, probleme, merite, fx, cx, Grad_x, d_QP, rho, borne_inf, borne_sup, outcome)
% pas d'Armijo
s = 1;

% condition de decroissante suffisante
c1 = 0.1;

% nombre d'évalutaion dans cette fonciton
nb_eval = 0;

% fonction de merite en le x courant
F_x = merite(fx, cx, rho);
nb_eval = nb_eval + 1;

% indicateur sur la reussite de la recherche lineaire d'Armijo
armijo = false;

% Initialisation de x comme x courant
x_opt = x;

% Initialisation de fx_next et cx_next comme fx et cx courant 
fx_next = fx; cx_next = cx;

% calcul de la derivee directionnelle
derivee_direction = Grad_x'*d_QP - rho * norm(cx, 1);

if derivee_direction >= 0
    % si la hessienne est deja reinitialise
    if(outcome == 2)
        return
    end
    % sinon on note comme 1
    outcome = 1;
    return
% si la derivee est negative, on fait la recherche lineaire
else
    while(s > 1e-6)
        xsd = x + s*d_QP;
        xsd = projection_bornes(xsd, borne_inf, borne_sup);
        [fx_xsd, cx_xsd] = probleme(xsd);
        nb_eval = nb_eval + 1;
        F_xsd = merite(fx_xsd, cx_xsd, rho);
        if(F_xsd < F_x + c1*s*derivee_direction)
            armijo = true;
            break;
        end
        s = s/2;
    end
    % si on reussit a trouver un bon pas d'armijo
    if armijo
        outcome = 0;
        % on garde cd xsd pour le pas prochain de SQP
        x_opt = xsd;
        % et on garde la valeur de fx et cx courant
        fx_next = fx_xsd; cx_next = cx_xsd;
        return
    else
        % si la derniere fois qu'on etait ici, on avait
        if(outcome == 0)
            % maintenant on marque l'echec car s est trop petit
            % si outcome est deja 2, on le laisse ainsi pour augmenter rho
            outcome = 1;
        end
        return
    end
end

end

