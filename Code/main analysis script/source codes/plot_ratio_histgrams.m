function [gof,gaussfit,lnZ,all_red_selected,all_blue_selected,y3,y4] = plot_ratio_histgrams(all_blue,all_red,lnORnormal,save_name,criterion)

switch lnORnormal
    
    
    case 'normal'
        
        ratio = all_red./(all_blue+all_red);
        bins = sshist(ratio);
        figure
        [y, x_axis] = hist(ratio,bins);
        y2 = y./sum(y);
        hold on
        bar(x_axis,y2);
        axis([0, 1, 0, 1]);
        xlabel('Ratio');
        ylabel('Frequency');
        title(strcat('n = ',num2str(length(ratio))));
        saveas(gcf,strcat(save_name,'_HistoRatio_',criterion,'.fig'), 'fig');
        %dlmwrite(strcat(save_name,'_ratio.txt'),ratio);
       
        gof = [];
        gaussfit = [];
        
    case 'lnZ'
        
        %lower_red_thres = quantile(all_red,[.2]);
        new_all_red = all_red;%(all_red>lower_red_thres);
        new_all_blue = all_blue;%(all_red>lower_red_thres);
        ratioLnZ = new_all_red./new_all_blue;
        ratioLnZpositive = ratioLnZ(ratioLnZ>0);
        all_red_selected = new_all_red(ratioLnZ>0);
        all_blue_selected = new_all_blue(ratioLnZ>0);
        lnZ = log(ratioLnZpositive);
        lnZ = lnZ(isfinite(lnZ)==1);
        binslnZ = -5.9:0.2:5.9; %sshist(lnZ);
        [y3, x_axis2] = hist(lnZ,binslnZ);
        y4 = y3./sum(y3);
        %Fit the data using a Gaussian function:
        [gaussfit,gof] = fit(x_axis2',y4','gauss1');
        if gof.rsquare <0.8
        [gaussfit,gof] = fit(x_axis2',y4','gauss2');
        end
        figure
        
        
        hold on
        bar(x_axis2,y4,'b');
        h = plot(gaussfit,'r');
        set(h,'LineWidth',2)
        axis([-4, 5, 0, 0.2]);
        xlabel('lnZ');
        ylabel('Frequency');
        title(strcat('n = ',num2str(length(lnZ))));
        saveas(gcf,strcat(save_name,'_HistoLnZ_',criterion,'.fig'), 'fig');
        hold off
        %dlmwrite(strcat(save_name,'_lnZ.txt'),lnZ);
        
  
end

        

   
    
    

    

  