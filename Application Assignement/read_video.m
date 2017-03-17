function [frames_out,H,W,T] = read_video(t_l)
    addpath ./MMread;
    T = 5;
    [vid,~] = mmread('../cars.avi',t_l:t_l+T);
%     [v1,~] = mmread('../cars.avi');
    frames = vid.frames;
    
    [H,W,~] = size(frames(1).cdata);
    
    frames_out = zeros(120,240,T);
    
    for i=1:T
        frames_out(:,:,i) = rgb2gray(frames(i).cdata(H-119:H,W-239:W,:));
    end
    H = 120;
    W = 240;
    rmpath ./MMread;
end
