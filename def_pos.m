function H = def_pos(HK, tau)

if min(eig(Hk)) < 0
    H = HK + eys(length(Hk)) * tau; 
end

H = HK;

end