function [H_z] = ct_to_dt_bilinear(H_s)
    H_z = c2d(H_s,0.5,'tustin');
end
