function smart_print(X)
% afficher le vecteur ou la matrice directement

[~, m] = size(X);

F = [repmat(' %5.2f',1 , m), '\n'];

fprintf(F, X.');

end