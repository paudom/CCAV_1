%% -- ALS_CODER -- %%
% -- This function acts as a coder -- %%

function [frame] = ALS_Decoder(bitstream,prev_frame)

	%% -- DEMULTIPLEXING -- %%
	[stream_alpha,coded_m,stream] = demultiplexing(bitstream);

	%% -- DECODE K -- %%
	alpha = alpha_decoding(stream_alpha);

	%% -- DEQUANTIFICATION OF PARCOR VALUES -- %%
    K_d = dequantify_parcor(alpha);
    
    %% -- PARCOR TO LPC COEFFICIENTS -- %%
    P = parcor2lpc(K_d);

	%% -- DECODE RESIDUAL -- %%
	residual = golomb_rice_decoding(stream,coded_m);

	%% -- DECODER LPC PREDICTOR -- %%
	frame = d_predictor(P,residual,prev_frame);
end
