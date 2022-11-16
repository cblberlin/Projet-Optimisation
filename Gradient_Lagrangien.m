function GradL = Gradient_Lagrangien(Grad_x, Grad_c, lambda)

%fprintf("le taille de gradient fx: %d * %d\n", size(Grad_x));  
%fprintf("le taille de gradient cx: %d * %d\n", size(Grad_c)); 
%fprintf("le taille de lambda : %d * %d\n", size(lambda)); 

GradL = Grad_x + lambda * Grad_c;

end