%% -- ALS_CODER -- %%
% -- This function acts as a coder -- %%

function bitstream = ALS_Coder(audio_signal)

	%% -- DECLARATION OF VARIABLES -- %%
	frame_samples = 1024;
	[frame_right,frame_left] = ALS_buffer(audio_signal,frame_samples);

	%% -- APPLYING THE HAMMING WINDOW -- %%
	frame_rw = apply_hamming(frame_right);
	frame_lw = apply_hamming(frame_left);

	%% -- ITERATION THROUGH FRAMES -- %%

	%% -- LEVINSON DURBIN -- %%
	K = levinson_durbin(frame_rw(:,125732));

	%% -- QUANTIFICATION OF PARCOR VALUES -- %%
	[alpha] = quantify_parcor(K);
	
    %% -- DEQUANTIFICATION OF PARCOR VALUES -- %%
    K_d = dequantify_parcor(alpha);
    
    %% -- PARCOR TO LPC COEFFICIENTS -- %%
    P = parcor2lpc(K_d);
    
    %% -- LPC PREDICTOR -- %%
    frame_right_p = filter(P,1,frame_right(:,125732));
    
    %% -- RESIDUAL SIGNAL -- %%
    residual = frame_right(:,125732)-frame_right_p;
    
    
end

