function [omega_p1,omega_p2,omega_s1,omega_s2] = get_ct_specifications(wp1,wp2,ws1,ws2)
    omega_p1 = tan(wp1/2);
    omega_p2 = tan(wp2/2);
    omega_s1 = tan(ws1/2);
    omega_s2 = tan(ws2/2);
end
