function [G_bs,G_z_bs] = get_bandstop_ct(N,epsilon,G_sl,s,B,omega_0)
    [~,p,~] = zpkdata(G_sl);
    pole_array = cell2mat(p);
    pole_array2 = pole_array(imag(pole_array) > 0); 
    G_bs = 1;
    G_z_bs = 1;
    %%%This is working%%%%%%%%%%%%%%%%%%%%%%%%
    sys_cd = tf([1 -1],[1 1],1/(90e3),'variable','z^-1');
    z_tmp1 = (B*sys_cd)/((sys_cd)^2 + omega_0^2);

    sys_tmp1 = (B*s)/(s^2 + omega_0^2);
    for i=1:length(pole_array)
        sys_tmp2 = sys_tmp1 - pole_array(i);
        z_tmp2 = z_tmp1 - pole_array(i);
        G_bs = G_bs/sys_tmp2;
        G_z_bs = G_z_bs/z_tmp2;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     sys_cd = tf([1 -1],[1 1],1/(90e3),'variable','z^-1');
%     sys_tmp1 = B*s/(s^2 + omega_0^2);
%     z_tmp1 = (B*sys_cd)/((sys_cd)^2 + omega_0^2);
%     
%     for i=1:length(pole_array2)
%         sys_tmp2 = sys_tmp1^2 - 2*real(pole_array2(i))*sys_tmp1 + pole_array2(i)*conj(pole_array2(i));
%         z_tmp2 = z_tmp1^2 - 2*real(pole_array2(i))*z_tmp1 + pole_array2(i)*conj(pole_array2(i));
%         G_bs = G_bs/sys_tmp2;
%         G_z_bs = G_z_bs/z_tmp2;
%     end    
%     if mod(N,2) == 1
%         p_f = pole_array(imag(pole_array) == 0);
%         sys_tmp2 = sys_tmp1 - p_f;
%         z_tmp2 = z_tmp1 - p_f;
%         G_bs = G_bs/sys_tmp2;
%         G_z_bs = G_z_bs/z_tmp2;
%     end
%     omega_max = 0*cos(pi/(2*N));
%     k1 = evalfr(G_bs,1i*omega_max);
%     G_bs = G_bs/k1;
%     w_max = 2*atan(omega_max);
%     k2 = evalfr(G_z_bs,exp(-1i*w_max));
%     G_z_bs = G_z_bs/k2;

    
end
