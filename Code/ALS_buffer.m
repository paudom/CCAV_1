function [frame] = ALS_buffer(ori_sig,samples)
    right=buffer(ori_sig(:,1),samples);
    left=buffer(ori_sig(:,2),samples);
    diff=left-right;
    frame=[right;left];
end