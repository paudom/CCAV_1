%% -- LEVINSON DURBIN -- %%
function [ K ] = levinson_durbin(frame)

	%% -- DEFINITION VARIABLES -- %%
	N = length(frame);
 	pmax = 127;
 	a = zeros(pmax,pmax); K = zeros(1,pmax);
 	A = zeros(1,pmax); J = zeros(1,pmax);
 	b = zeros(1,pmax);
    iterations = 0; maxiter = 5;

	%% -- COMPUTE THE FRAME AUTOCORRELATION -- %%
	R = zeros(1,N);
	for m = 0:N-1
		R(m+1) = sum(frame(m+1:N).*frame(1:N-m));
		if(R(m+1)==0)
			R(m+1)=1e-7;
		end
    end
    
 	%% -- LEVINSON DURBIN INITIALIZATION -- %%
 	a(1,1) = 1; J(1) = R(1);
 	b(1) = floor(log2(J(1)));
    
 	%% -- LEVINSON DURBIN RECURSION -- %%
 	for p = 1:pmax-1
 		A(p) = fliplr(R(1:p+1))*a(1:p+1,p);
 		K(p) = -A(p)/J(p);
        if(p>1)
            a(1,p+1) = 1;
            for i = 2:p
                a(i,p+1) = a(i,p)+K(p)*a(p-i+2,p);
            end
        else
            a(p,p+1) = 1;
        end
        a(p+1,p+1) = K(p);
 		J(p+1)=J(p)*(1-K(p)^2);
 		b(p+1) = floor(log2(abs(round(J(p+1)))));
 		if(b(p+1)>b(p)|| iterations == maxiter)
 			break;
        end
        if(b(p+1)==b(p))
            iterations = iterations + 1;
        end
 	end
 	K = K(1:p-1);
 	
end