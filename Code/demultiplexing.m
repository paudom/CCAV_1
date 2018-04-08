%% -- DEMULTIPLEXING THE BITS -- %%
function [stream_alpha,coded_m,stream] = demultiplexing(bitstream)

	%% -- DEMULTIPLEXING THE BITS -- %%
	ini_stream = strsplit(bitstream,'H');
	stream_alpha = ini_stream(1); % separated by K
	coded_m = ini_stream(2);
	stream = ini_stream(3); 
end