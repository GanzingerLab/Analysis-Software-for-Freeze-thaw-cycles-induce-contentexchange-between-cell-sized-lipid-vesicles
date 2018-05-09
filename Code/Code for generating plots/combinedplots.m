  heatscatter(log10(all_red_ampli_collected{1}),log10(all_blue_ampli_collected{1}),save_name,'_heatscatterplot.fig',100,20,'.', 1, 0, 'red', 'green','');
   hold on
  heatscatter(log10(all_red_ampli_collected{2}),log10(all_blue_ampli_collected{2}),save_name,'_heatscatterplot.fig',100,20,'.', 1, 0, 'red', 'green','');
   
   heatscatter(log10(all_red_ampli_collected{3}),log10(all_blue_ampli_collected{3}),save_name,'_heatscatterplot.fig',100,20,'.', 1, 0, 'red', 'green','');
    
        set(gca,'XLim', [3 5],'YLim',[3 5]);%'XTickLabel', {'10^3' '10^4' '10^5'},'YTickLabel',{'10^3' '10^4' '10^5'});
        xticks([3 4 5]);
        xticklabels({'10^3' '10^4' '10^5'});
        yticks([3 4 5]);
        yticklabels({'10^3' '10^4' '10^5'});
        
        figure
        scatter(log10(all_red_ampli_collected{1}),log10(all_blue_ampli_collected{1}),100,'.r');
   hold on
  scatter(log10(all_red_ampli_collected{2}),log10(all_blue_ampli_collected{2}),100,'.b');
   
   scatter(log10(all_red_ampli_collected{3}),log10(all_blue_ampli_collected{3}),100,'.g');
    
        set(gca,'XLim', [3.5 5],'YLim',[3 5],'DataAspectRatio',[1 1 1]);%'XTickLabel', {'10^3' '10^4' '10^5'},'YTickLabel',{'10^3' '10^4' '10^5'});
        xticks([3 4 5]);
        xticklabels({'5*10^3' '10^4' '10^5'});
        yticks([3 4 5]);
        yticklabels({'10^3' '10^4' '10^5'});
        xlabel('red (dye outside)')
        ylabel('green')
        legend({'-20,RT','-80,RT','control'})
        