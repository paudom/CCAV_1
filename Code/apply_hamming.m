%% -- FUNCTION APPLY HIMMAING -- %%
function [ frame_windowed ] = apply_hamming(frame)

	%% -- INITIALIZATING MATRICES -- %%
	[rows,cols] = size(frame);
	frame_windowed = zeros(rows,cols); 

	%% -- DEFINITION HAMMING WINDOW -- %%
	w = hamming(rows);

	%% -- APPLYING THE HAMMING WINDOW -- %%
	for i=1:cols
		frame_windowed(:,i) = double(frame(:,i)).*w;
    end
    frame_windowed = int16(frame_windowed);
	
end