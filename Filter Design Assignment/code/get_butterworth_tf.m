function [H_s_L] = get_butterworth_tf(N,omega_c,s)
    s0 = 1i*omega_c;
    sys1 = 1/(1 + (s/s0)^(2*N));
    warning('off','last');
    [z,p,k] = zpkdata(sys1);
    z = cell2mat(z);
    p = cell2mat(p);
    p1 = p( real(p) < 0);
    z1 = [];
    [num,den] = zp2tf(z1,p1,1);
    H_s_L = tf(num,den);
    k1 = evalfr(H_s_L,0);
    H_s_L = H_s_L/k1;
    
end
