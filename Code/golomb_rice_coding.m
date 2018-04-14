%% -- ENTROPY CODER OF THE RESIDUAL VALUES USING COLOMB-RICE CODES -- %%
function [stream, coded_m] = golomb_rice_coding(res)

    %% -- DEFINITTION OF VARIABLES -- %%
    mu = mean(abs(res));
    s = floor(log2(mu)+0.97);
    m = pow2(s);
    q = zeros(1,length(res));
    r = zeros(1,length(res));
    mbits = ceil(log2(m));
    rembits = ceil(log2(m-1));
    stream = '';

    %% -- CODING M VALUE OF GOLOMB RICE -- %%
    coded_m = dec2bin(m,mbits);

    %% -- MERGE POSITIVES AND NEGATIVES -- %%
    ind_pos = find(res > 0); res(ind_pos) = 2*res(ind_pos);
    ind_neg = find(res < 0); res(ind_neg) = -2*res(ind_neg)-1;

    %% -- CODING THE RESIDUAL -- %%
    for i=1:length(res)
        q(i) = floor(res(i)/m);
        r(i) = res(i)-q(i)*m;
        s_rem = dec2bin(r(i),rembits);
        s_q = '0';
        if(q(i)>0)
            for j = 1:q(i)
                s_q = strcat('1',s_q);
            end
        end
        stream = strcat(stream,strcat(s_rem,s_q,'R'));
    end
    
        
end

