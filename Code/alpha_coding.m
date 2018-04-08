%% -- ALPHA CODING WITH 7 BITS -- %%
function stream = alpha_coding(alpha)

	%% -- DEFINITION OF VARIABLES -- %%
	stream = '';
	Nbits = 7;

	%% -- CODING -- %%
	for i = 1:length(alpha)
		stream = strcat(stream,dec2bin(alpha(i),Nbits),'K');
	end

end