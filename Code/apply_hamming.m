%% -- FUNCTION APPLY HIMMAING -- %%
function [ frame_windowed ] = apply_hamming(frame)

	%% -- INITIALIZATING MATRICES -- %%
	[rows,cols] = size(frame);
	frame_windowed = zeros(rows,cols); 

	%% -- DEFINITION HAMMING WINDOW -- %%
	w = hamming(rows);

	%% -- APPLYING THE HAMMING WINDOW -- %%
	for i=1:cols
		frame_windowed(:,i) = frame(:,i).*w;
	end
	
end