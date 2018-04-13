%% -- CODER PREDICTOR -- %%
function [frame_p] = c_predictor(P,prev_frame,frame)

	%% -- DECLARATION OF VARIABLES -- %%
    prev_frame = double(prev_frame);
    frame = double(frame);
	samples = length(frame);
	order_p = length(P);
    frame_p = zeros(samples,1);
  
    %% -- PREDICTION -- %%
	for i = 1:length(frame)
        if(i<=order_p)
            frame_p(i) = P*[frame((i-1):-1:1);prev_frame(samples:-1:samples-order_p+i)];
        else
            frame_p(i) = P*frame((i-1):-1:(i-order_p));
        end
    end
end