function [dquant_output] = Unif_DQuant(quant_input)
    
    % -- Declaration of variables -- %
    input_max = 1; %ceil(max(input_signal)); 
    input_min = -1; %floor(min(input_signal));
    %Funciona per números decimals,pensant que el rang és entre -1 i 1...
    %però si no és així s'hauria de pensar com fer-ho o! posar directament
    %els paràmetres del rang.
    b = 3; %Pensar si es passa com a paràmetre
    Q = (input_max-input_min)/pow2(b);
    dquant_output = zeros(1,length(quant_input));
    k_max = pow2(b)/2;
    
    % -- Quantization -- %
    for i=1:length(quant_input)
        for k=1:k_max
            if ((((2*(k-1)+1)*Q/2))<=abs(quant_input(i)))&&(abs(quant_input(i))<=((2*(k-1)+1)*Q/2))
                if(quant_input(i)>0)
                    dquant_output(i)=(2*(k-1)+1)*Q/2;
                elseif(quant_input(i)<0)
                    dquant_output(i)=(-1)*(2*(k-1)+1)*Q/2;
                elseif(quant_input(i)==0)    
                    dquant_output(i)=0;
                end 
            end
        end
    end

end

