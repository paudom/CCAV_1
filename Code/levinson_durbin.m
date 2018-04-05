%% -- LEVINSON DURBIN -- %%
function [ K ] = levinson_durbin(frame)

	%% -- DEFINITION VARIABLES -- %%
	N = length(frame);
	pmax = 127;
	a = zeros(1,pmax); K = zeros(1,pmax);
	A = zeros(1,pmax); J = zeros(1,pmax);
	b = zeros(1,pmax);

	%% -- COMPUTE THE FRAME AUTOCORRELATION -- %%
	R = zeros(1,N);
	for m = 1:N
		R(m) = sum(frame(m:N).*frame(1:N-m-1));
	end

	%% -- LEVINSON DURBIN INITIALIZATION -- %%
	a(1) = 1; J(1) = R(1);
	b(1) = floor(log2(J(1)));

	%% -- LEVINSON DURBIN RECURSION -- %%
	for p = 1:pmax
		A(p) = dot(R(1:p+1),fliplr(a(1:p+1)));
		K(p) = -A(p)/J(p);
		a(p+1) = Kp);
		if(p > 1)
			for i = 1:(p-1)
				a(i) = a(i)+K(p)*a(p-i);
			end
		end
		J(p+1)=J(p)*(1-K(p)^2);
		b(p+1) = floor(log2(J(p+1)));
		if(p > 1 && b(p+1)>b(p))
			break;
		end
	end
	K = K(1:p-1);
	
end