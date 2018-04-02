function [quantized_output,output2] = Unif_Quant(input)

  % -- Declaration of variables -- %
    input_signal = asin(input);
    input_max = asin(ceil(max(input))); 
    input_min = asin(floor(min(input)));
    b = 3; %Pensar si es passa com a paràmetre
    Q = (input_max-input_min)/pow2(b);
    quantized_output = zeros(1,length(input_signal));
    output2 = zeros(1,length(input_signal));
    k_max = pow2(b)/2;
    
  % -- Quantization -- %
    for i=1:length(input_signal)
        output2(i) = max(input_min,min(floor(input_signal(i)/Q),input_max));
        for k=1:k_max
            if ((((k-1)*Q)<=abs(input_signal(i)))&&(abs(input_signal(i))<=(k*Q)))
                if(input_signal(i)>0)
                    quantized_output(i)=(0.5+(k-1))*Q;
                elseif(input_signal(i)<0)
                    quantized_output(i)=(-0.5-(k-1))*Q;
                elseif(input_signal(i)==0)    
                    quantized_output(i)=0;
                end 
            end      
        end
    end
end

