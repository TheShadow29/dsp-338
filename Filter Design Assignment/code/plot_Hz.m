function [] = plot_Hz(H_z)
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
%     [h,w] = freqz(H_z,1024);
    plot(w,abs(h));
end
