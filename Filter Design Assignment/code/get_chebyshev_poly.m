function [Cn] = get_chebyshev_poly(N,s,omega_p)

    s0 = 1i*omega_p;
    s1 = s/s0;
    
    sysN_0 = 1;
    sysN_1 = s1;
    
    n1 = N - 1;

    while(n1>0)
        sysN_2 = 2*s1*sysN_1 - sysN_0;
        sysN_0 = sysN_1;
        sysN_1 = sysN_2;
        n1 = n1 - 1;
    end
    
    if(N == 0)
        Cn = 1;
    elseif(N == 1)
        Cn = s1;
    else
        Cn = sysN_2;
    end
%     [coeff,~]= tfdata(Cn);
%     coeff = cell2mat(coeff);
end
