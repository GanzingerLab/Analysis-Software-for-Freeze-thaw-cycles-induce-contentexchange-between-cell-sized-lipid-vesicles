function [all_means_int all_std_int] = save_fit_parameters(int_fitres,f,thresholdcriterion,sample,Rsquare) 
 
coeffvals_int = coeffvalues(int_fitres);
all_means_int = coeffvals_int(2);
all_std_int = coeffvals_int(3);
        
fprintf(f,'%s\t%s\t%f\t%f\t%f\t%f\n',sample,thresholdcriterion,coeffvals_int(1),coeffvals_int(2),coeffvals_int(3),Rsquare);

end