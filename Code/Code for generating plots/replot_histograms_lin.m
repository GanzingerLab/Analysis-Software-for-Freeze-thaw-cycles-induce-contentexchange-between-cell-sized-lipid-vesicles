order = [4 2 1 3]; 

name = {'before FT','8060','20RT','80RT'};
figure
for i =1:4
    
%      heatscatter(log10(all_red_ampli_collected{i}),log10(all_blue_ampli_collected{i}),save_name,'_heatscatterplot.fig',130,20,'.', 1, 0, 'red', 'green','');
%        
%         set(gca,'XLim', [2.5 5],'YLim',[2.5 5],'DataAspectRatio',[1 1 1]);%'XTickLabel', {'10^3' '10^4' '10^5'},'YTickLabel',{'10^3' '10^4' '10^5'});
%         xticks([2.5 3 4 5]);
%         xticklabels({'5*10^2' '10^3' '10^4' '10^5'});
%         yticks([2.5 3 4 5]);
%         yticklabels({'5*10^2' '10^3' '10^4' '10^5'});
%         
%         colorbar;
%         saveas(gcf,strcat(name{i},'_heatscatterplot_log','.svg'), 'svg');
%     close(1)
%     
% ratio = (all_red_ampli_collected{order(i)}./max(all_red_ampli_collected{order(i)}))./(((all_red_ampli_collected{order(i)}./max(all_red_ampli_collected{order(i)}))+(all_blue_ampli_collected{order(i)})./max(all_blue_ampli_collected{order(i)})));
%        bins = sshist(ratio);
 meanints(i) = mean(all_blue_ampli_collected{order(i)}+all_red_ampli_collected{order(i)});
 meanints_blue(i) = mean(all_blue_ampli_collected{order(i)});
 meanints_red(i) = mean(all_red_ampli_collected{order(i)});
        int_combined = all_red_ampli_collected{order(i)}+all_blue_ampli_collected{order(i)};
        x_axis_limit = 10^5;%ceil(max(all_blue_ampli_collected{order(i)}));
        %bins = sshist(int_combined);



        figure(3)
        subplot(4,1,i)
        %[y, x_axis] = hist(ratio,bins);
%         if i == 1
%             bins = 50;
%         else
%             bins = x_axis;
%         end
        bins = [0:2000:100000];
        [y, x_axis] = hist(int_combined,bins);
        y2 = y./sum(y);
          hold on
        bar(x_axis,y2,'FaceColor',[1 1 1],'EdgeColor',[0.3 0.3 0.3],'LineWidth',1.5);
        axis([0, x_axis_limit, 0, 0.3]);%max(y2)+0.05]);
        %axis([0, 1, 0, max(y2)+0.05]);
        %xlabel('Ratio');
        xlabel('Intensity');
        ylabel('Frequency');
        %title(strcat('n = ',num2str(length(ratio))));
       title(strcat(name{i}, '; n = ',num2str(length(all_red_ampli_collected{order(i)}))));
       
       
        


end    
%saveas(gcf,strcat(save_name,'_HistoLnZ_combined.eps'), 'eps');
       