function smart_print(X)
% afficher le vecteur ou la matrice par appel de la fonction

[~, m] = size(X);

F = [repmat(' %8.4f',1 , m), '\n'];

fprintf(F, X.');

end