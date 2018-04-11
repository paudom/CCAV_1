%% -- AUDIO RECONSTRUCTOR -- %%
function output = audio_reconstructor(frame_r,frame_l)

	%% -- DEFINITION OF VARIABLES -- %%
	[~,cols] = size(frame_r);
	right_channel = []; left_channel = [];
	frame_r = int16(frame_r); frame_l = int16(frame_l);

	%% -- WRITE AUDIO FILE -- %%
	while(i <= cols)
		right_channel = [right_channel;frame_r(:,i)];
		left_channel = [left_channel;frame_l(:,i)];
		i = i +1;
	end
	output = [right_channel left_channel];
end