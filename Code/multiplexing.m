%% -- MULTIPLEXING THE BITS -- %%
function bitstream = multiplexing(alpha,m,stream)

	%% -- INICIALIZATION -- %%
	bitstream = '';

	%% -- MULTIPLEXING THE BITS -- %%
	bitstream = strcat(alpha,'H',m,'H',stream);
end