function getstats_vs7(lnZ_int,lnZ_int_next,ratio4xaxis,ratio4xaxis_next,thresholdcriterion,mode,fid)
 
        
        
      
       
 
        sc = sprintf(strcat('Samples compared (',mode,'): %s and %s'),ratio4xaxis,ratio4xaxis_next);
        disp(sc)
        fprintf(fid, strcat('Samples compared (',mode,'): %s and %s \n'),ratio4xaxis,ratio4xaxis_next);
     
   
        % t-test of the null hypothesis that data in the vectors x and y are independent random samples
        % from normal distributions with equal means and unequal and unknown variances
        % syntax ttest: sample1, sample2, alpha, tail, variance assumption
        
        [h,p] = ttest2(lnZ_int,lnZ_int_next,[],[],'unequal');
        ttestres = sprintf(strcat('p-value: %d , test result for ','',thresholdcriterion),p);
        disp(ttestres)
        fprintf(fid,strcat('p-value: %d , test result for ',thresholdcriterion,'\n'),p);
%         [h,p] = ttest2(lnZ_ma,lnZ_ma_next,[],[],'unequal');
%         ttestres = sprintf('p-value: %d and test result for amplitude derived int %g',p,h);
%         disp(ttestres)
       
end