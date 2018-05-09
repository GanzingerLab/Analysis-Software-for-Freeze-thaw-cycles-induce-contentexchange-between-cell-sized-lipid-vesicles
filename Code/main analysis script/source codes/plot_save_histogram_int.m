function plot_save_histogram_int(ints,type,save_name,folders2analyse)
global n2
rect_matched = [34 524 560 420];

if strcmp(type,'blue') == 1,
    figure_index =  1;
elseif strcmp(type,'red') == 1,
    figure_index = 2;
end


switch figure_index
    case 1
        figure
        colour = 'b';
        fName = strcat(save_name,'_histogram_int_green.dat');
    case 2
        figure
        colour = 'r';
        fName = strcat(save_name,'_histogram_int_red.dat');

end


set(gcf,'position',rect_matched);

x_axis_limit = ceil(max(ints));
bins = sshist(ints);
%bar(distances,mean);

if ~isempty(ints)
[y, xout] = hist(ints,bins);
y2 = y./sum(y);
hold on
bar(xout,y2,colour);
axis([0, x_axis_limit, 0, max(y2)]);
xlabel('Intensity');
ylabel('Frequency');
if iscell(folders2analyse) == 1
title(strcat('Intensity Distribution for: ',folders2analyse{n2}));
else
title(strcat('Intensity Distribution'));
end

switch figure_index
    case 1
        saveas(gcf, [strcat(save_name,'_histogram_int_green.fig')]);    
    case 2
        saveas(gcf, [strcat(save_name,'_histogram_int_red.fig')]);
end

    file_output = fopen(fName,'w');

    for n=1:length(y2),
        fprintf(file_output, '%d\t %f\n',xout(n),y2(n));
    end

    fclose(file_output);
end
