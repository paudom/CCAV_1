function [p,Parcor] = ALS_CEQ(signal)
    % Pasos:
    % -- Primer Calcular la autocorrelacio dels frames r
    % -- Després utilitzar la funció levinson, per trobar el ordre util
    n=2;
    while(1)
    [~,pre_err,parcor]=levinson(r,n);
    % -- Estima els bits que utilitzes per transmetre l'error de prediccio
    % y els coeficients parcor.
    % -- Si s'utilitzen més bits que el model p-1, es fa break i et
    % quedes amb el p-1
    if(bits_p > bits_p-1)
        break;
    end
end