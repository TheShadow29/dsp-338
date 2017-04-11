function [G_bs,G_z_bs,G_z_bs_actual] = get_bandstop_ct(N,epsilon,G_sl,s,B,omega_0)
    [~,p,~] = zpkdata(G_sl);
    pole_array = cell2mat(p);
    pole_array2 = pole_array(imag(pole_array) > 0); 
    G_bs = 1;
    G_z_bs = 1;
    sys_tmp1 = (B*s)/(s^2 + omega_0^2);
    sys_cd = tf([1 -1],[1 1],1/(90e3),'variable','z^-1');
    sys_cd = minreal(sys_cd);
    z_tmp1 = -(B*sys_cd)/((sys_cd)^2 + omega_0^2);
    z_tmp1 = minreal(z_tmp1);
    %%%This is working%%%%%%%%%%%%%%%%%%%%%%%%

% 
%     for i=1:length(pole_array)
%         sys_tmp2 = sys_tmp1 - pole_array(i);
%         z_tmp2 = z_tmp1 - pole_array(i);
%         G_bs = G_bs/sys_tmp2;
%         G_z_bs = G_z_bs/z_tmp2;
%     end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i=1:length(pole_array2)
        sys_tmp2 = sys_tmp1*(sys_tmp1 - 2*real(pole_array2(i))) + pole_array2(i)*conj(pole_array2(i));
        z_tmp2 = z_tmp1^2 - 2*real(pole_array2(i))*z_tmp1 + pole_array2(i)*conj(pole_array2(i));
        G_bs = G_bs/sys_tmp2;
        G_z_bs = G_z_bs/z_tmp2;
    end
    
    if mod(N,2) == 1
        p_f = pole_array(imag(pole_array) == 0);
        sys_tmp2 = sys_tmp1 - p_f;
        z_tmp2 = z_tmp1 - p_f;
        G_bs = G_bs/sys_tmp2;
        G_z_bs = G_z_bs/z_tmp2;
    end
    
%     k1 = abs(evalfr(G_sl,1i*0));
%     G_bs = G_bs/k1;
%     omega_max = 1 * cos(pi/(2*N));
%     omega_max2 = (B*omega_max + sqrt(B^2 * omega_max^ + 4 * omega_0^2))/2;
%     wmax = 2*atan(omega_max2);
%     k2 = abs(evalfr(G_z_bs,exp(-1i*wmax)));
    k2=2^(N-1) * epsilon;
    G_z_bs = G_z_bs/k2;
    G_bs = G_bs/k2;
    [n,d] = bilinear(cell2mat(G_bs.num),cell2mat(G_bs.den),0.5);
    G_z_bs_actual = tf(n,d,1/(90e3),'variable','z^-1');    
end
