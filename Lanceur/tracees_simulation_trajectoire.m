function tracees_simulation_trajectoire(y_1, y_2, y_3, t_1, t_2, t_3, R_terre, H_c, R_c, V_c)

% position
R_x = [y_1(:,1); y_2(:,1); y_3(:,1)];
R_y = [y_1(:,2); y_2(:,2); y_3(:,2)];

% vitesse
V_x = [y_1(:,3); y_2(:,3); y_3(:,3)];
V_y = [y_1(:,4); y_2(:,4); y_3(:,4)];

% masse
M_all = [y_1(:,5); y_2(:,5); y_3(:,5)];

% temps total 
t = [t_1 ; t_2; t_3];

% norme de la position
R_norm = sqrt(R_x.^2 + R_y.^2);
h = R_norm - R_terre;
% norme de la vitesse
V_norm  = sqrt(V_x.^2 + V_y.^2);

% TRACEES: 

% ------------------------ y en fonction de x --------------------------- %
figure();
plot(y_1(:,1), y_1(:,2), 'b');
hold on;
plot(y_2(:,1), y_2(:,2), 'r');
hold on;
plot(y_3(:,1), y_3(:,2), 'g');
hold on;
viscircles([0 0], R_terre, 'Color', 'k', 'LineWidth', 0.7);
viscircles([0 0], R_c, 'Color', 'b', 'LineWidth', 0.5, 'LineStyle', '--');
%xlim([4e6 8e6]);
%ylim([-0.5e6 4e6]);
xlabel("R_x"); ylabel("R_y");
title("Position: x en fonction de y");

% ----------- altitude h (norme R - R_terre) en fonction de t ------------%
figure();
plot(t(1:size(t_1)), h(1:size(t_1)), 'b');
hold on;
plot(t(size(t_1): size(t_1) + size(t_2)), h(size(t_1):size(t_1) + size(t_2)), 'r');
hold on;
plot(t(size(t_1) + size(t_2):end), h(size(t_1) + size(t_2):end), 'g');
hold on;
plot(t, repmat(H_c, 1, numel(t)), 'r--');
xlabel("temps t"); ylabel("hauteur h");
title("Hauteur en fonction du temps");

% --------------------- norme V en fonction de t -------------------------%
figure();
plot(t, V_norm); 
hold on;
plot(t, repmat(V_c, 1, numel(t)), 'r--');
xlabel("temps t");
ylabel("norme de V");
title("Norme de la vitesse en fonction du temps");

% --------------------- masse en fonction de t ---------------------------%
figure();
plot(t, M_all, 'r');
xlabel("temps t"); ylabel("masse du lanceur");
title("Masse en fonction du temps");

end