function [wp1,wp2,ws1,ws2] = get_discrete_specifications(sample_frq,B_l,B_h,transition_band)
    wp1 = B_l*2*pi/sample_frq;
    wp2 = B_h*2*pi/sample_frq;
    ws1 = wp1 - 2*pi*1/sample_frq;
    ws2 = wp2 + 2*pi*1/sample_frq;
end
