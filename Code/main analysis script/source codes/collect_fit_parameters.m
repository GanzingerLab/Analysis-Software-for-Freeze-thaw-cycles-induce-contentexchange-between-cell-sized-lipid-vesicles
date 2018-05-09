function [all_means,all_std] = collect_fit_parameters(type,gof,int_fitres,folders2analysis,plottitle,save_name)
    
    fid = fopen(strcat(save_name,type,'.dat'),'a');
    fprintf(fid, 'Fit Parameters\n');
    fprintf(fid, 'data set \t criterion \t a \t b \t c \t Rsquared \n');
    
   
     
    %ratio4xaxis =  zeros(length(gof)-1,1);
    all_means = zeros(length(gof)-1,1);
    all_std = zeros(length(gof)-1,1);
    
    
    for n3=1:length(gof)
        if isfield(gof{n3}, 'rsquare')
            %label(n3) = folders2analysis{n3};
            [all_means(n3), all_std(n3)] = save_fit_parameters(int_fitres{n3},fid,'AND',folders2analysis{n3},gof{n3}.rsquare);
        end
    end
    fclose(fid);
   
    
     
    h1 = figure;
   % axes1 = axes('Parent',h1,'XTickLabel',folders2analysis);
    %box(axes1,'on');
    %hold(axes1,'all');
    errorbar(all_means,all_std,'o');
    hold on
    set(gca, 'XTick',1:length(folders2analysis), 'XTickLabel',folders2analysis)
    title(plottitle)
    saveas(h1,strcat(save_name,type,'.fig'), 'fig');
    
end