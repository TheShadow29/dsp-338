function [H_s_bp,H_z_bp] = get_bandpass_ct(N,H_s_L,s,B,omega_0)
    [~,p,~] = zpkdata(H_s_L);
     pole_array = cell2mat(p);
     pole_array2 = pole_array(imag(pole_array) > 0); 
%      p_f = pole_array
     H_s_bp = 1;
     H_z_bp = 1;
%%%%%%%%%%%This works
%     sys_tmp1 = (s^2 + omega_0^2)/(B*s);
%     for i=1:length(pole_array)
%         sys_tmp2 = sys_tmp1 - pole_array(i);
%         H_s_bp = H_s_bp/sys_tmp2;
%     end
%%%%%%%%%%%%%%%%%
    sys_cd = tf([1 -1],[1 1],1/(140e3),'variable','z^-1');
%     z = tf('z');
%     sys_cd = (1 - 1/z)*(1+1/z);
    sys_tmp1 = (s^2 + omega_0^2)/(B*s);
    z_tmp1 = ((sys_cd)^2 + omega_0^2)/(B*sys_cd);
    
    for i=1:length(pole_array2)
        sys_tmp2 = sys_tmp1^2 - 2*real(pole_array2(i))*sys_tmp1 + pole_array2(i)*conj(pole_array2(i));
        z_tmp2 = z_tmp1^2 - 2*real(pole_array2(i))*z_tmp1 + pole_array2(i)*conj(pole_array2(i));
        H_s_bp = H_s_bp/sys_tmp2;
        H_z_bp = H_z_bp/z_tmp2;
    end    
    if mod(N,2) == 1
        p_f = pole_array(imag(pole_array) == 0);
        sys_tmp2 = sys_tmp1 - p_f;
        z_tmp2 = z_tmp1 - p_f;
        H_s_bp = H_s_bp/sys_tmp2;
        H_z_bp = H_z_bp/z_tmp2;
    end
    k1 = evalfr(H_s_bp,omega_0);
    H_s_bp = H_s_bp/k1;
    w0 = 2*atan(omega_0);
    k2 = evalfr(H_z_bp,exp(-1i*w0));
    H_z_bp = H_z_bp/k2;
   
end
