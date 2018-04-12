%% -- ALS_CODER -- %%
% -- This function acts as a coder -- %%

function [frame,fstate] = ALS_Decoder(bitstream,state,previous_frame)

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
	[frame_p,fstate] = filter(1,P,previous_frame,state);

	%% -- RECUPERING THE LOSSLESS FRAME -- %%
	frame = int16(residual+round(frame_p));
end
