%% -- ALS_CODER -- %%
% -- This function acts as a coder -- %%

function bitstream = ALS_Coder(audio_signal,audio_struct)

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
	[alpha, Q, xmin] = quantify_parcor(K);
	
end

