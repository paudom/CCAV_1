%% -- ALS_CODER -- %%
% -- This function acts as a coder -- %%

function [bitstream,fstate] = ALS_Coder(frame,state)

	%% -- APPLYING THE HAMMING WINDOW -- %%
	frame_w = apply_hamming(frame);

	%% -- LEVINSON DURBIN -- %%
	K = levinson_durbin(frame_w);

	%% -- QUANTIFICATION OF PARCOR VALUES -- %%
	[alpha] = quantify_parcor(K);

	%% -- CODING PARCORS -- %%
	alpha_stream = alpha_coding(alpha);
	
    %% -- DEQUANTIFICATION OF PARCOR VALUES -- %%
    K_d = dequantify_parcor(alpha);
    
    %% -- PARCOR TO LPC COEFFICIENTS -- %%
    P = parcor2lpc(K_d);
    
    %% -- LPC PREDICTOR -- %%
	[frame_p,fstate] = filter(P,1,frame,state);
    
    %% -- RESIDUAL SIGNAL -- %%
    residual = frame-int16(round(frame_p));
    
    %% -- GOLOMB RICE CODING THE RESIDUAL -- %%
    [stream, m_coded] = golomb_rice_coding(residual);

    %% -- MULTIPLEXING -- %%
    bitstream = multiplexing(alpha_stream,m_coded,stream);
end

