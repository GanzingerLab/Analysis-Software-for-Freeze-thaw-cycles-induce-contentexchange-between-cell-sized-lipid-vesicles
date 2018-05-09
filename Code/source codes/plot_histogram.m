function plot_histogram(distance_bin,coloc_mean,coloc_std,type,exp_name,save_name,maxD)


if strcmp(type,'blue') == 1,
    figure_index =  1;
else
    figure_index = 2;
end


x_axis_limit = maxD.*distance_bin;
distances = [(1:maxD).*distance_bin];
%bar(distances,mean);


switch figure_index
    case 1
        figure
        colour = 'b';
    case 2
        colour = 'r';
%     case 3
%         hold off
%         figure(2)
%         colour = 'b';
%     case 4
%         colour = 'r';
end

[x] = [coloc_mean.(type)];
[xerror] = [coloc_std.(type)];
hold on
errorbar(distances,x,xerror,colour);
axis([0, x_axis_limit, 0, 100]);
xlabel('Distance (nm)');
ylabel('% Coincidence');
title(strcat('Coincidence for ',exp_name));


switch figure_index
    case 1
        saveas(gcf, [strcat(save_name,'_histogram_green.fig')]);    
    case 2
        saveas(gcf, [strcat(save_name,'_histogram_red.fig')]);
%     case 3
%         saveas(gcf, [strcat(results,'\', exp_name,'_histogram_shuffled_green.fig')]);    
%     case 4
%         saveas(gcf, [strcat(results,'\', exp_name,'_histogram_shuffled_red.fig')]);
end
