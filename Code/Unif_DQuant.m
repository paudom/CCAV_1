function [dquant_output] = Unif_DQuant(quant_input)
    
    % -- Declaration of variables -- %
    input_max = asin(ceil(max(input_signal))); 
    input_min = asin(floor(min(input_signal)));
    b = 3; %Pensar si es passa com a paràmetre
    Q = (input_max-input_min)/pow2(b);
    dquant_output = zeros(1,length(quant_input));
    k_max = pow2(b)/2;
    interval=zeros(1,k_max);
    for n=1:length(interval)
        interval(n+1)=2*n;
    end
    
    
    % -- Quantization -- %
    for i=1:length(quant_input)
        for k=1:k_max
            if (((interval(k)*Q/2))<=abs(quant_input(i)))&&(abs(quant_input(i))<=(interval(k+1)*Q/2))
                if(quant_input(i)>0)
                    dquant_output(i)=quant_input(i)*Q+Q/2;
                elseif(quant_input(i)<0)
                    dquant_output(i)=quant_input(i)*Q+Q/2;
                elseif(quant_input(i)==0)    
                    dquant_output(i)=0;
                end 
            end
        end
    end

end

