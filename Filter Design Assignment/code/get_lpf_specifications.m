function [omega_lp,omega_ls] = get_lpf_specifications(B,omega_0,omega_p1,omega_p2,omega_s1,omega_s2)
    omega_lp1 = trans_bp_w(omega_p1,B,omega_0);
    omega_lp2 = trans_bp_w(omega_p2,B,omega_0);
    omega_lp = min(abs(omega_lp1),abs(omega_lp2));
    
    omega_ls1 = trans_bp_w(omega_s1,B,omega_0);
    omega_ls2 = trans_bp_w(omega_s2,B,omega_0);
    omega_ls = min(abs(omega_ls1),abs(omega_ls2));
end
