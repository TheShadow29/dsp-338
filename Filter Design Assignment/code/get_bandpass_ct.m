function [H_s_bp,H_z_bp,H_z_bp_actual] = get_bandpass_ct(N,H_s_L,s,B,omega_0)
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
    z_tmp_minus = tf([1 -1],1,1/(140e3),'variable','z^-1');
    z_tmp_plus = tf([1 1],1,1/(140e3),'variable','z^-1');
    
    z_tmp3 = z_tmp_minus^2 + omega_0^2 * z_tmp_plus^2;
    z_tmp4 = B * z_tmp_minus * z_tmp_plus;
    
    for i=1:length(pole_array2)
%         sys_tmp2 = sys_tmp1^2 - 2*real(pole_array2(i))*sys_tmp1 + pole_array2(i)*conj(pole_array2(i));
        
        sys_tmp2 = sys_tmp1*(sys_tmp1 - 2*real(pole_array2(i))) + pole_array2(i)*conj(pole_array2(i));
        
        z_tmp2 = z_tmp1^2 - 2*real(pole_array2(i))*z_tmp1 + pole_array2(i)*conj(pole_array2(i));
%         z_tmp2 = z_tmp1*(z_tmp1 - 2*real(pole_array2(i))) + pole_array2(i)*conj(pole_array2(i));

%         z_tmp2 = z_tmp_minus^4 + z_tmp_minus^3 * z_tmp_plus * (-2*real(pole_array2(i)) * B) + ...
%                     z_tmp_minus^2 * z_tmp_plus^2 *(2*omega_0^2 + abs(pole_array2(i))^2 * B^2) + ...
%                     -2*real(pole_array2(i))*B*omega_0^2 * z_tmp_minus*z_tmp_plus^3 + omega_0^4*z_tmp_plus^4;
%         z_tmp2 = z_tmp2/(B*z_tmp_minus^2*z_tmp_plus^2);        
        
%         z_tmp2 = (z_tmp3^2 - 2*real(pole_array2(i)) * z_tmp3  * z_tmp4 + abs(pole_array2(i))^2 * z_tmp4^2)/z_tmp4^2;

        
        H_s_bp = H_s_bp/sys_tmp2;
        H_z_bp = H_z_bp/z_tmp2;
    end    
    if mod(N,2) == 1
        p_f = pole_array(imag(pole_array) == 0);
        sys_tmp2 = sys_tmp1 - p_f;
        z_tmp2 = z_tmp1 - p_f;
%         z_tmp2 = z_tmp_minus^2 - B*p_f*z_tmp_minus*z_tmp_plus + omega_0^2*z_tmp_plus;
%         z_tmp2 = z_tmp2/(B*z_tmp_minus*z_tmp_plus);
%         z_tmp2 = (z_tmp3 -p_f * z_tmp4)/z_tmp4;
        H_s_bp = H_s_bp/sys_tmp2;
        H_z_bp = H_z_bp/z_tmp2;
    end
    k1 = abs(evalfr(H_s_bp,1i*omega_0));
    H_s_bp = H_s_bp/k1;
    w0 = 2*atan(omega_0);
    k2 = abs(evalfr(H_z_bp,exp(-1i*w0)));
    H_z_bp = H_z_bp/k2;
%     plot_Hz(H_z_bp);
    [n,d] = bilinear(cell2mat(H_s_bp.num),cell2mat(H_s_bp.den),0.5);
    H_z_bp_actual = tf(n,d,1/(140e3),'variable','z^-1');
end
