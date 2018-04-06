function [a] = parcor2lpc(K)
    a = zeros(1,length(K));
    for i=1:length(K)
        a(i) = k(i);
        if(i>1)
            for j=1:i-1
                a(j)=a(j)-k(i)*a(i-j);
            end
        end
    end
end

