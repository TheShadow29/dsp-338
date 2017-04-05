function [H_z] = ct_to_dt_bilinear(H_s)
    [num_c,den_c] = tfdata(H_s);
    [num_z,den_z] = bilinear(num_c,den_c,0.5);
%     [zc,pc,kc] = zpkdata(H_s);
%     zc = cell2mat(zc);
%     pc = cell2mat(pc);
%     [zd,pd,kd] = bilinear(zc,pc,kc,0.5);
%     num = poly(zd);
%     den = poly(pd);
    
end
