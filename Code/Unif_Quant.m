function [quantized_output] = Unif_Quant(input_signal)

  % -- Declaration of variables -- %
    input_max = ceil(max(input_signal)); 
    input_min = floor(min(input_signal));
    %Funciona per números decimals,pensant que el rang és entre -1 i 1...
    %però si no és així s'hauria de pensar com fer-ho o! posar directament
    %els paràmetres del rang.
    b = 3; %Pensar si es passa com a paràmetre
    Q = (input_max-input_min)/pow2(b);
    quantized_output = zeros(1,length(input_signal));
    k_max = pow2(b)/2;
    
  % -- Quantization -- %
    for i=1:length(input_signal)
        for k=0:1:(k_max-1)
            if (((k*Q)<=abs(input_signal(i)))&&(abs(input_signal(i))<=((k+1)*Q)))
                if(input_signal(i)>0)
                    quantized_output(i)=(0.5+k)*Q;
                elseif(input_signal(i)<0)
                    quantized_output(i)=(-0.5-k)*Q;
                elseif(input_signal(i)==0)    
                    quantized_output(i)=0;
                end 
            end      
        end
    end
end

