%% -- ALPHA DECODING WITH 7 BITS -- %%
function alpha = alpha_coding(stream)

	%% -- DECODING ALPHAS-- %%
	alpha_stream = strsplit(stream{1},'K');
	alpha = zeros(1,length(alpha_stream));
	for i = 1:length(alpha_stream)
		alpha(i) = bin2dec(alpha_stream(i));
	end

end