%% -- QUANTIFY PARCOR COEFFICIENTS -- %%
function [alpha, Q, xmin] = quantify_parcor(K)

	%% -- DEFINITION VARIABLES -- %%
	ak = (2/pi)*asin(K);
	xmin = min(ak);
	N = 2^7;
	Q = (max(ak)-xmin)/N;

	%% -- QUANTIFICATION OF Ak -- %%
	Code_book = floor((ak-xmin)/Q);
	alpha = max(0,min(Code_book,N-1));

end