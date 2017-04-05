function [omega_l] = trans_bs_w(omega,B,omega_0)
    omega_l = (B*omega)/(omega_0^2 - omega^2);
end
