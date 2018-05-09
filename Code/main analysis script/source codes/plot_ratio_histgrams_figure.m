function [gof,gaussfit,lnZ] = plot_ratio_histgrams_figure(all_blue,all_red,lnORnormal,normalisation,save_name,criterion,fitopt)

switch lnORnormal
    
    
    case 'normal'
        
        ratio = all_red./(all_blue+all_red);
        bins = sshist(ratio);
        figure
        [y x_axis] = hist(ratio,bins);
        y2 = y./sum(y);
        hold on
        bar(x_axis,y2);
        axis([0, 1, 0, 1]);
        xlabel('Ratio');
        ylabel('Frequency');
        title(strcat('n = ',num2str(length(ratio)),normalisation));
        saveas(gcf,strcat(save_name,'_HistoRatio_',criterion,'_',normalisation,'.fig'), 'fig');
        %dlmwrite(strcat(save_name,'_ratio.txt'),ratio);
       
        gof = [];
        gaussfit = [];
        
    case 'lnZ'
        ratioLnZ = all_red./all_blue;
        ratioLnZpositive = ratioLnZ(ratioLnZ>0);
        lnZ = log(ratioLnZpositive);
        lnZ = lnZ(isfinite(lnZ)==1);
        
        if fitopt == 1
        binslnZ = sshist(lnZ);
        [y3 x_axis2] = hist(lnZ,binslnZ);
        y4 = y3./sum(y3);
        %Fit the data using a Gaussian function:
        
        [gaussfit,gof] = fit(x_axis2',y4','gauss1');
       
        figure
        
        
        hold on
        bar(x_axis2,y4,'b');
        h = plot(gaussfit,'r');
        set(h,'LineWidth',2)
        axis([-4, 5, 0, 0.3]);
        xlabel('lnZ');
        ylabel('Frequency');
        title(strcat('n = ',num2str(length(lnZ)),normalisation));
        saveas(gcf,strcat(save_name,'_HistoLnZ_',criterion,'_',normalisation,'.fig'), 'fig');
        hold off
        %dlmwrite(strcat(save_name,'_lnZ.txt'),lnZ);
        else
            gof = [];
            gaussfit =[];
        
        end
        
%         if strcmp(criterion,'OR')
%         
%       
%         coeffvals = coeffvalues(gaussfit);
%         mean_05_int_lnZ = coeffvals(2);
%         mean_05_int = exp(mean_05_int_lnZ);
%         
%         new_red = all_red/mean_05_int;
%         SUM = new_red+all_blue;    
%         binsthres = sshist(SUM);
%         [y5 x_axis3] = hist(SUM,binsthres);
%         y6 = y5./sum(y5);
%         
%         figure
%         
%         
%         hold on
%         bar(x_axis3,y5,'b');
%         xlabel('sum of intensities');
%         ylabel('Frequency');
%         title(strcat('n = ',num2str(length(SUM)),'distribution of summed intensities'));
%         saveas(gcf,strcat(save_name,'_dist_summed_int','.fig'), 'fig');
%         hold off
%         
%         end
end

        

   
    
    

    

  