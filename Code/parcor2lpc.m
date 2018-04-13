%% -- CONVERT PARCOR VALUES TO LPC COEFFICIENTS -- %%
function [P] = parcor2lpc(K)

	%% -- DEFINITION OF VARIABLES -- %%
    a = zeros(length(K),length(K));

    %% -- CONVERTING PARCOR TO LPC -- %%
    a(1,1) = 1;
    for p=1:length(K)-1
        if(p>1)
            a(1,p+1) = 1;
            for i = 2:p
                a(i,p+1) = a(i,p)+K(p)*a(p-i+2,p);
            end
        else
            a(p,p+1) = 1;
        end
        a(p+1,p+1) = K(p);
    end
    P = a((2:length(K)),length(K)).';
end

