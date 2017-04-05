function [N,epsilon] = chebyshev_lpf_specifications(omega_lp,omega_ls,delta_1,delta_2)
    D1 = -1 + (1./(1 - delta_1))^2;
    D2 = -1 + (1./(delta_2))^2;
    n_min = acosh(D2/D1)/acosh(omega_ls/omega_lp);
    N = ceil(n_min);
    
    epsilon = sqrt(D1);
end
