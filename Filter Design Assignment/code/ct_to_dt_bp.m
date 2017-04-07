function [H_z] = ct_to_dt_bp(H_s_bp)
%     H_z = c2d(H_s,0.5,'tustin');
    [zc,pc,kc] = zpkdata(H_s_bp,'v');
    sys_cd = tf([1 -1],[1 1],1/140,'variable','z^-1');
    H_z = tf(1,1,1/140,'variable','z^-1');
    for i = 1:length(zc)
        sys_tmp = sys_cd - zc(i);
        H_z = H_z * sys_tmp;
    end
    
    for j = 1:length(pc)
        sys_tmp = sys_cd - pc(i);
        H_z = H_z / sys_tmp;
    end
    
    
end
