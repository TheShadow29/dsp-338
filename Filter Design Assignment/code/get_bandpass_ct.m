function [H_s_bp] = get_bandpass_ct(H_s_L,s,B,omega_0)
    [~,p,~] = zpkdata(H_s_L);
     pole_array = cell2mat(p);
     pole_array2 = pole_array(imag(pole_array) >= 0); 
     H_s_bp = 1;
     for i=1:length(pole_array2)
%         sys_tmp = (s^2 - B*pole_array(i)*s + omega_0^2)/(B * s);
        sys_tmp1 = (s^2 + omega_0^2)/(B*s);
        sys_tmp2 = sys_tmp1^2 - 2 * real(pole_array2(i))*sys_tmp1 + abs(pole_array2(i))^2;
        H_s_bp = H_s_bp / sys_tmp2;
     end   
end
