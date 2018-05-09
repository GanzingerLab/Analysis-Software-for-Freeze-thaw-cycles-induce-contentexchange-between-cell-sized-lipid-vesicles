order = [4 2 1 3]; 
figure
for i =1:4
binslnZ = -5.9:0.2:5.9; %sshist(lnZ);
        [y3, x_axis2] = hist(lnZ_AND_ampli{order(i)},binslnZ);
        y4 = y3./sum(y3);
        %Fit the data using a Gaussian function:
        [gaussfit,gof] = fit(x_axis2',y4','gauss1');
        if gof.rsquare <0.8
        [gaussfit,gof] = fit(x_axis2',y4','gauss2');
        end
       
        subplot(4,1,i)
        
        hold on
        bar(x_axis2,y4,'FaceColor',[1 1 1],'EdgeColor',[0.3 0.3 0.3],'LineWidth',1.5);
        h = plot(gaussfit,'r');
        set(h,'LineWidth',2)
        axis([-4, 5, 0, max(y4)+0.05]);
        xlabel('lnZ');
        ylabel('Frequency');
        title(strcat('n = ',num2str(length(lnZ_AND_ampli{order(i)}))));
        


end    
saveas(gcf,strcat(save_name,'_HistoLnZ_combined.eps'), 'eps');
       