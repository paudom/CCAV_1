%% -- BUFFER -- %%
function [frame_right,frame_left] = ALS_buffer(audio_signal,frame_samples)
    frame_right = buffer(audio_signal(:,1),frame_samples);
    frame_left = buffer(audio_signal(:,2),frame_samples);
    frame_right = frame_right(:,(1:300));
    frame_left = frame_left(:,(1:300));
end