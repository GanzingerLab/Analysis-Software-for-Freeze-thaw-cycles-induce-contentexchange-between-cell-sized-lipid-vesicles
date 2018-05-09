function [gof,gaussfit,lnZ,new_red,all_red,all_blue] = plot_ratio_histgrams_norm(all_blue,all_red,lnORnormal,normalisation,save_name,fit_results05,sum_threshold,criterion)

coeffvals = coeffvalues(fit_results05);
mean_05_int_lnZ = coeffvals(2);
mean_05_int = exp(mean_05_int_lnZ);

switch lnORnormal
    
    
    case 'normal'
        
        ratio = (all_red/mean_05_int)./(all_blue+(all_red/mean_05_int));
        bins = sshist(ratio);
        figure
        [y x_axis] = hist(ratio,bins);
        y2 = y./sum(y);
        hold on
        bar(x_axis,y2);
        axis([0, 1, 0, 1]);
        xlabel('Ratio');
        ylabel('Frequency');
        title(strcat('n = ',num2str(length(ratio)),normalisation,' after ',criterion,' threshold'));
        saveas(gcf,strcat(save_name,'_HistoRatio_',criterion,'_',normalisation,'.fig'), 'fig');
        %dlmwrite(strcat(save_name,'_ratio.txt'),ratio);
       
        gof = [];
        gaussfit = [];
        
    case 'lnZ'
        new_red = all_red/mean_05_int;
        ratioLnZ = new_red./all_blue;
        ratioLnZpositive = ratioLnZ(ratioLnZ>0);
        lnZ = log(ratioLnZpositive);
        lnZ = lnZ(isfinite(lnZ)==1);
        binslnZ = sshist(lnZ);
        [y3 x_axis2] = hist(lnZ,binslnZ);
        y4 = y3./sum(y3);
        %Fit the data using a Gaussian function:
        [gaussfit,gof,fitres] = fit(x_axis2',y4','gauss1');
        
        
        gaussfit
        
        figure
        
        
        hold on
        bar(x_axis2,y4,'b');
        h = plot(gaussfit,'r');
        set(h,'LineWidth',2)
        axis([-4, 5, 0, 0.3]);
        xlabel('lnZ');
        ylabel('Frequency');
        title(strcat('n = ',num2str(length(lnZ)),normalisation,' after ',criterion,' threshold'));
        saveas(gcf,strcat(save_name,'_HistoLnZ_',criterion,'_',normalisation,'.fig'), 'fig');
        hold off
        %dlmwrite(strcat(save_name,'_lnZ.txt'),lnZ);
end

        

   
    
    

    

  