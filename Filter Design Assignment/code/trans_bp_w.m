function [omega_l] = trans_bp_w(omega,B,omega_0)
    omega_l = (omega.^2 - omega_0.^2)./(B * omega);
end
