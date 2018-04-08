%% -- LEVINSON DURBIN -- %%
function [ K ] = levinson_durbin(frame)

	%% -- DEFINITION VARIABLES -- %%
	N = length(frame);
% 	pmax = 127;
% 	a = zeros(1,pmax); K = zeros(1,pmax);
% 	A = zeros(1,pmax); J = zeros(1,pmax);
% 	b = zeros(1,pmax);

	%% -- COMPUTE THE FRAME AUTOCORRELATION -- %%
	R = zeros(1,N);
	for m = 0:N-1
		R(m+1) = sum(frame(m+1:N).*frame(1:N-m));
    end
    
    [a,J,K] = levinson(R,10);
% 	%% -- LEVINSON DURBIN INITIALIZATION -- %%
% 	a(1,1) = 1; J(1) = R(1);
% 	b(1) = floor(log2(J(1)));
% 
% 	%% -- LEVINSON DURBIN RECURSION -- %%
% 	for p = 1:10
% 		A(p) = dot(R(1:p+1),fliplr(a(1:p+1)));
% 		K(p) = -A(p)/J(p);
% 		a(p+1) = K(p);
% 		if(p > 1)
% 			for i = 1:(p-1)
% 				a(i) = a(i)+K(p)*a(p-i);
% 			end
% 		end
% 		J(p+1)=round(J(p)*(1-K(p)^2));
% 		b(p+1) = floor(log2(abs(J(p+1))));
% 		if(b(p+1)>b(p))
% 			break;
% 		end
% 	end
% 	K = K(1:p-1);
% 	
end