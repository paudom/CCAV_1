%% -- DEQUANTIFY PARCOR COEFFICIENTS -- %%
function [ K ] = dequantify_parcor(alpha)

	%% -- DEFINITION VARIABLES -- %%
	xmax = pi/2;
	xmin = -pi/2;
	N = 2^7;
	Q = (xmax-xmin)/N;

	%% -- QUANTIFICATION OF Ak -- %%
	beta = alpha*Q+Q/2+xmin;
    K = sin(beta);

end