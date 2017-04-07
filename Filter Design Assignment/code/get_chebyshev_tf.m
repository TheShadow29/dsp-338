function [G_sl] = get_chebyshev_tf(N,epsilon,s,omega_lp)
    Cn = get_chebyshev_poly(N,s,omega_lp);
    sys1 = 1/(1 + epsilon^2*Cn^2);
    [~,p,~] = zpkdata(sys1);
    p = cell2mat(p);
    p1 = p(real(p) < 0);
    z1 = [];
    [num,den] = zp2tf(z1,p1,1);
    G_sl = tf(num,den);
    omega_max = omega_lp*cos(pi/(2*N));
    k1 = evalfr(G_sl,1i*omega_max);
%     k11 = sqrt(1+epsilon^2);
    G_sl = G_sl/k1;
    
end
