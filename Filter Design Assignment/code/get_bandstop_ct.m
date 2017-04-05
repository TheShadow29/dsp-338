function [G_bs] = get_bandstop_ct(N,G_sl,s,B,omega_0)
    [~,p,~] = zpkdata(G_sl);
    pole_array = cell2mat(p);
    pole_array2 = pole_array(imag(pole_array) > 0); 
    G_bs = 1;

%     for i=1:length(pole_array2)
%         sys_tmp1 = (B*s)/(s^2 + omega_0^2);
%         sys_tmp2 = sys_tmp1^2 - 2 * real(pole_array2(i))*sys_tmp1 + abs(pole_array2(i))^2;
%         G_bs = G_bs / sys_tmp2;
%     end
%     p_f = pole_array(imag(pole_array) == 0);
%     sys_tmp2 = sys_tmp1 - p_f;
%     G_bs = G_bs/sys_tmp2;

    sys_tmp1 = (B*s)/(s^2 + omega_0^2);
    for i=1:length(pole_array)
        sys_tmp2 = sys_tmp1 - pole_array(i);
        G_bs = G_bs/sys_tmp2;
    end
    
%         sys_tmp1 = (B*s)/(s^2 + omega_0^2);
%     for i=1:length(pole_array2)
%         sys_tmp2 = sys_tmp1^2 - 2*real(pole_array2(i))*s + abs(pole_array2)^2;
%         G_bs = G_bs/sys_tmp2;
%     end
%     if(mod(N,2))
%         p_f = pole_array(imag(pole_array) == 0);
%         sys_tmp2 = sys_tmp1 - p_f;
%         G_bs = G_bs/sys_tmp2;
%     end
    
end
