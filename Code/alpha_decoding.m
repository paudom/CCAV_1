%% -- ALPHA DECODING WITH 7 BITS -- %%
function alpha = alpha_decoding(stream)

	%% -- DECODING ALPHAS-- %%
	alpha_stream = strsplit(stream{1},'K');
	alpha = zeros(1,length(alpha_stream)-1);
	for i = 1:length(alpha_stream)-1
		alpha(i) = bin2dec(alpha_stream{i});
	end

end