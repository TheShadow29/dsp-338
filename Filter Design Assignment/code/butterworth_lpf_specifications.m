function [N,omega_c] = butterworth_lpf_specifications(omega_lp,omega_ls,delta_1,delta_2)
    %delta_1 and delta_2 < 1
    D1 = -1 + (1./(1 - delta_1))^2;
    D2 = -1 + (1./(delta_2))^2;
    n_min = log(D2/D1)/(2*log(omega_ls/omega_lp)); 
    N = ceil(n_min);
    
    D1_n = (D1)^(1/(2*N));
    D2_n = (D2)^(1/(2*N));
    omega_c1 = omega_lp/D1_n;
    omega_c2 = omega_ls/D2_n;
    
    omega_c = mean([omega_c1,omega_c2]);
%     omega_c = sqrt(omega_c1 * omega_c2);
    
end
