%% -- ENTROPY DECODER OF THE RESIDUAL VALUES USING COLOMB-RICE CODES -- %%
function [residual] = golomb_rice_decoding(stream,coded_m)

	%% -- M EXTRACTION -- %%
	m = bin2dec(coded_m);
	rembits = ceil(log2(m-1));

	%% -- RESIDUAL EXTRACTION -- %%
	res_values = strsplit(stream{1},'R');
	r = zeros(1,length(res_values));
	q = zeros(1,length(res_values));
	for i = 1:length(res_values)
		value = res_value(i);
		r(i) = bin2dec(value{1}(1:rembits));
		q_value = res{1}(rembits+1:length(res{1}));
		q(i) = 0;
		for j = 1:length(q_value)
			if(q_value(j)=='1')
				q(i) = q(i) + 1;
			end
		end
		res_plus = q(i)*m+r(i);
		if(rem(res_plus,2)>0)
			residual(i) = ceil(res_plus/2)*-1;
		else
			residual(i) = res_plus/2;
		end
	end
end