function save_histogram(save_name,distance_bin,coloc_mean,coloc_std,type)


if strcmp(type,'blue') == 1,
    figure_index =  1;
else
    figure_index = 2;
end

switch figure_index
    
    case 1
        fName = strcat(save_name,'_histogram_green.dat');
    case 2
        fName = strcat(save_name,'_histogram_red.dat');
%     case 3
%         fName = strcat(results,'\',exp_name,'_histogram_shuffled_green.dat');        
%     case 4
%         fName = strcat(results,'\',exp_name,'_histogram_shuffled_red.dat');        
end

    file_output = fopen(fName,'w');

    for n=1:length([coloc_mean.(type)]),
        distance = n.*distance_bin;
        fprintf(file_output, '%d\t %f\t %f\n',distance,coloc_mean(1,n).(type),coloc_std(1,n).(type));
    end


    fclose(file_output);

