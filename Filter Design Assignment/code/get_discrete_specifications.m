function [wp1,wp2,ws1,ws2] = get_discrete_specifications(sample_frq,B_l,B_h,arg1)
    if(strcmp(arg1,'bp'))
        wp1 = B_l*2*pi/sample_frq;
        wp2 = B_h*2*pi/sample_frq;
        ws1 = wp1 - 2*pi*1/sample_frq;
        ws2 = wp2 + 2*pi*1/sample_frq;
    elseif (strcmp(arg1,'bs'))
        ws1 = B_l*2*pi/sample_frq;
        ws2 = B_h*2*pi/sample_frq;
        wp1 = (B_l - 1)*2*pi/sample_frq;
        wp2 = (B_h + 1)*2*pi/sample_frq;
    end
end
