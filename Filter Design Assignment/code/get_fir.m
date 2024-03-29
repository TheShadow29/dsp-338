function [h_fir_n,H_fir,H_fir_z,N] = get_fir(arg1,delta,wp1,wp2,ws1,ws2)
    A = -20*log10(delta);
    delta_w = min(abs(wp1- ws1),abs(wp2-ws2));
    n1 = ceil(1 + (A - 8)/(2.285*delta_w));
    if (strcmp(arg1,'bp'))
        N = ceil((A - 8)/(2*2.285*delta_w))+4;
    end
    if (strcmp(arg1,'bs'))
        N = ceil((A - 8)/(2*2.285*delta_w))+1;
    end
    
%     N = (n1-1)/2;
    
    n_vec = -N:1:N;
    wav_1 = (wp1 + ws1)/2;
    wav_2 = (wp2 + ws2)/2;
    if (strcmp(arg1,'bp'))
        h_ideal_n = (sin(wav_2*n_vec) - sin(wav_1*n_vec))./(pi*n_vec);
        h_ideal_n(n_vec == 0) = (wav_2 - wav_1)/pi;

        kaiser_window = kaiser(2*N+1,0);

        h_fir_n = h_ideal_n.*kaiser_window';
        
        w_range = 0:pi/1024:pi;
        H_fir = zeros(size(w_range));

        for i=1:length(w_range)
            for k=1:length(h_fir_n)
                H_fir(i) = H_fir(i) + h_fir_n(k)*exp(-1j*w_range(i)*n_vec(k));
            end
        end
    end
    
    if (strcmp(arg1,'bs'))
        h_ideal_n = sin(pi*n_vec)./(pi*n_vec) - (sin(wav_2*n_vec) - sin(wav_1*n_vec))./(pi*n_vec);
        h_ideal_n(n_vec == 0) = 1 - (wav_2 - wav_1)/pi;
        
        kaiser_window = kaiser(2*N+1,0);
        h_fir_n = h_ideal_n.*kaiser_window';
        w_range = 0:pi/1024:pi;
        H_fir = zeros(size(w_range));
        
        for i=1:length(w_range)
            for k=1:length(h_fir_n)
                H_fir(i) = H_fir(i) + h_fir_n(k)*exp(-1j*w_range(i)*n_vec(k));
            end
        end
        
    end
    
    one1_plus = ones(size(H_fir)) + 0.1;
    one1_minus = ones(size(H_fir)) - 0.1;
    zero_plus = zeros(size(H_fir)) + 0.1;
        
    h1 = 0:0.01:1.2;
    wp1_all = wp1 * ones(size(h1));
    wp2_all = wp2 * ones(size(h1));
    ws1_all = ws1 * ones(size(h1));
    ws2_all = ws2 * ones(size(h1));
    
    figure;
    plot(w_range,abs(H_fir));
    hold on;
%     plot(w_range,angle(H_fir));
    plot(w_range,one1_plus);
    plot(w_range,one1_minus);
    plot(w_range,zero_plus);
    plot(wp1_all,h1);
    plot(wp2_all,h1);
    plot(ws1_all,h1);
    plot(ws2_all,h1);
    hold off;
    if(strcmp(arg1,'bp'))
        str = sprintf('Band Pass FIR with order %d',N);
        title(str);
    end
    
    if (strcmp(arg1,'bs'))
        str = sprintf('Band Stop FIR with order %d',N);
        title(str);
    end
    figure; 
    freqz(h_fir_n,1,1024);
    if strcmp(arg1,'bp')
        str_dash = sprintf('Frequency Response for BandPass FIR Filter Order %d',N);
    else
        str_dash = sprintf('Frequency Response for BandStop FIR Filter Order %d',N);
    end
    title(str_dash);
    
    
    str1 = '';
    h_fir_pos = h_fir_n(n_vec >= 0);
    for i=N:-1:0
        str1 = strcat(str1,num2str(h_fir_pos(i+1)),'z^{',num2str(-i),'} + ');
    end
    h_fir_neg = h_fir_n(n_vec < 0);
    for i=-1:-1:-N
        str1 = strcat(str1,num2str(h_fir_neg(i+N+1)),'z^{',num2str(-i),'} + ');
    end

    fprintf(str1);
    if(strcmp(arg1,'bp'))
        fs = 140e3;
    else 
        fs = 90e3;
    end
    H_fir_z = tf(h_fir_pos,1,1/fs,'variable','z^-1');
%     sysd_tmp = tf(flipdim(h_fir_neg,2),1,1/fs,'variable','z');
%     z1 = tf([1,0],1,1/fs,'variable','z');
%     H_fir_z = sysd_tmp*z1 + H_fir_z1;

end