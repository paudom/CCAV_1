% The Levinson Durbin Algorithm
% pred_coef: prediction filter coefficients are {a_{P,1} a_{P,2} a_{P,3} ....... a_{P,P}}}  
% pred_var is 1D prediction error variance.
% See appendix J in K. Vasudevan, “Digital Communications and Signal Processing, Second edition”, Universities Press (hyderabad), India. 
% For symbol notation: follow strictly the above book.
% Cor_Vector: is the autocorrelation of the Wide sense stationary random sequence (it should be a column vector, for this code to work!)
% prediction_depth: is the order of the prediction filter.
% pred_coef are the prediction filter coefficients
% pred_var is the 1D prediction error variance
% length of the prediction_depth should greater than the length of the Cor_vector.
% Written by Vineel Kumar Veludandi

function[pred_coef,pred_var]=Gen_Coef(Cor_Vector,prediction_depth)

% initialization of prediction coefficient, error variances, reflection
% coefficient matrices.
pred_coef_matrix = eye(prediction_depth+1,prediction_depth+1); % prediction coefficient: 1st row represents prediction coef for zeroth order.
ref_coef_vector = zeros(prediction_depth,1); % Reflection Coefficient
pred_var_vector = zeros(prediction_depth,1); % 1D prediction error variance

%-------------------------------------------------------------------------- 
% initial conditions for the recursive algorithm
% pred_coef = 1; % zeroth order prediction coefficient:  a_{0,0}
ref_coef = -Cor_Vector(2)/Cor_Vector(1); % Reflection Coefficient for 1st order predictor:   K_1
pred_var = Cor_Vector(1); % 1D prediction error variance of zeroth order.:   a_{1,1}
%-------------------------------------------------------------------------- 

pred_coef_matrix(2,1) = ref_coef; % 1st order: 
ref_coef_vector(1) = ref_coef; % 1st order
pred_var_vector(1) = (1 - (abs(ref_coef))^2)*pred_var; % 1st order


% recursion. (for 2nd order onwards)

for i=1:prediction_depth-1
    
%--------------------------------------------------------------------------    
% step1 : reflection coef & Pth order predictor coefficient calculation
ref_coef_vector(1+i) = -1*(pred_coef_matrix(1+i,1:1+i)*Cor_Vector(2:2+i))/pred_var_vector(i); % K_P
pred_coef_matrix(2+i,1) = ref_coef_vector(1+i); % a_{P,P}

%-------------------------------------------------------------------------- 
% step2: prediction coef from P-2th to 1th coefficients of Pth order.
pred_coef_matrix(2+i,2:2+i-1)=pred_coef_matrix(1+i,1:1+i-1)+ref_coef_vector(1+i)* fliplr(conj(pred_coef_matrix(1+i,1:1+i-1))); % {a_{P,P-1}......a_{P,1}}
  
%--------------------------------------------------------------------------
% step3: prediction error variance calculation for P th order
pred_var_vector(1+i) = (1 - (abs(ref_coef_vector(1+i)))^2)*pred_var_vector(i); % \cal E_{P}
    
end

pred_var = pred_var_vector(prediction_depth); % prediction error variance 1D
%ref_coef = ref_coef_vector(prediction_depth); % reflection coefficient
pred_coef =  fliplr(pred_coef_matrix(prediction_depth+1,1:prediction_depth));
end
