function H = modif_hess(H_,tau)
%MODIF_HESS Summary of this function goes here
%   Detailed explanation goes here

n = length(H_);
H = H_;
if(min(eig(H)) < 1e-2)
    H = H_ + tau * eye(n);
end

end

