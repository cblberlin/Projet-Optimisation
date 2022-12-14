function u = u(eh, er, gamma, theta)
    % attention aux radians vs degres
    u = eh * cosd(gamma + theta) + er * sind(gamma + theta);
end