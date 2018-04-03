%% -- ALS_CODER -- %%
% -- This function acts as a coder -- %%

function bitstream = ALS_Coder(audio_signal,audio_struct)

	%% -- DECLARATION OF VARIABLES -- %%
	frame_samples = 1024;
	[frame_right,frame_left] = ALS_buffer(audio_signal,frame_samples);

	%% -- CODING THE SIGNAL -- %%
	
end

