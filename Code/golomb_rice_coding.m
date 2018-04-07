%% -- ENTROPY CODER OF THE RESIDUAL VALUES USING COLOMB-RICE CODES -- %%
function [stream, coded_m] = golomb_rice_coding(res)

    %% -- DEFINITTION OF VARIABLES -- %%
    mu = mean(res);
    s = floor(log2(mu)+0.97);
    m = pow2(s);
    q = zeros(1,length(res));
    r = zeros(1,length(res));
    mbits = ceil(log2(m));
    rembits = ceil(log2(m-1));
    stream = '';

    %% -- CODING M VALUE OF GOLOMB RICE -- %%
    coded_m = dec2bi(m,mbits);

    %% -- CODING THE RESIDUAL -- %%
    for i=1:length(res)
        if(res(i)>0)
            res(i) = 2*res(i);
        else
            res(i) = -2*res(i)-1;
        end
        q(i) = floor(res(i)/m);
        r(i) = res(i)-q(i)*m;
        s_rem = dec2bi(r(i),rembits);
        if(q(i)>1)
            s_q = '0';
            for j = 1:q(i)
                s_q = strcat('1',s_q);
            end
        else
            s_q = '0';
        end
        stream = strcat(stream,strcat(s_rem,s_q));
    end
    
        
end

