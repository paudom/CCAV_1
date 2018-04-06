%% -- QUANTIFY PARCOR COEFFICIENTS -- %%
function [alpha] = quantify_parcor(K)

	%% -- DEFINITION VARIABLES -- %%
	ak = asin(K);
    xmax = pi/2;
	xmin = -pi/2;
	N = 2^7;
	Q = (xmax-xmin)/N;

	%% -- QUANTIFICATION OF Ak -- %%
	Code_book = floor((ak-xmin)/Q);
	alpha = max(0,min(Code_book,N-1));

end