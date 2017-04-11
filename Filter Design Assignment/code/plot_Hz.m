function [] = plot_Hz(H_z,wp1,wp2,ws1,ws2)
% [h,w]=freqz(cell2mat(H_z.num),cell2mat(H_z.den),10000);
% plot(w,abs(h)/max(abs(h)));
% freqz(cell2mat(H_z.num),cell2mat(H_z.den),10000);
%     
%     w = 0:0.01:pi;
%     h = zeros(size(w));
%     for i=1:length(w)
%         h(i) = abs(evalfr(H_z,w(i)));
%     end
% %     h = h/max(h);
%     plot(w,h);
  [h,w] = freqz(cell2mat(H_z.num),cell2mat(H_z.den),1024);
% %     [h,w] = freqz(H_z,1024);
%     freqz(cell2mat(H_z.num),cell2mat(H_z.den),1024,'whole');
    one1_plus = ones(size(h)) + 0.1;
    one1_minus = ones(size(h)) - 0.1;
    zero_plus = zeros(size(h)) + 0.1;
    h1 = 0:0.01:1.2;
    wp1_all = wp1 * ones(size(h1));
    wp2_all = wp2 * ones(size(h1));
    ws1_all = ws1 * ones(size(h1));
    ws2_all = ws2 * ones(size(h1));

    plot(w,abs(h));
    hold on
    plot(w,one1_plus);
    plot(w,one1_minus);
    plot(w,zero_plus);
    plot(wp1_all,h1);
    plot(wp2_all,h1);
    plot(ws1_all,h1);
    plot(ws2_all,h1);
    hold off;
    
end
