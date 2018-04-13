%% -- ALS_CODER -- %%
% -- This function acts as a coder -- %%

function [bitstream] = ALS_Coder(prev_frame,frame)

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
    frame_p = c_predictor(P,prev_frame,frame);
    
    %% -- RESIDUAL SIGNAL -- %%
    residual = round(double(frame)-frame_p);
    
    %% -- GOLOMB RICE CODING THE RESIDUAL -- %%
    [stream, m_coded] = golomb_rice_coding(residual);

    %% -- MULTIPLEXING -- %%
    bitstream = multiplexing(alpha_stream,m_coded,stream);
end

