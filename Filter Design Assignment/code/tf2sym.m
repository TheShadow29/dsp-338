function [T] = tf2sym(t,x)
    [num,den] = tfdata(t);
%     syms x;
    T = poly2sym(cell2mat(num),x)/poly2sym(cell2mat(den),x);
end
