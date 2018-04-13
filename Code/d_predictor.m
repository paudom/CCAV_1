%% -- DECODER PREDICTOR -- %%
function frame = d_predictor(P,residual,prev_frame)

	%% -- DECLARATION OF VARIABLES -- %%
    prev_frame = double(prev_frame);
	samples = length(prev_frame);
	frame = zeros(samples,1);
	order_p = length(P);

	%% -- RECONSTRUCTING FRAME -- %%
	for i = 1:length(frame)
        if(i<=order_p)
            frame(i) = round(residual(i)+(P*[frame((i-1):-1:1);prev_frame(samples:-1:samples-order_p+i)]));
        else
            frame(i) = round(residual(i)+(P*frame((i-1):-1:(i-order_p))));
        end
    end
    
end