function H = modif_hess(H_,tau)
%MODIF_HESS Summary of this function goes here
%   Detailed explanation goes here

n = length(H_);

H = H_ + tau * eye(n);

end

