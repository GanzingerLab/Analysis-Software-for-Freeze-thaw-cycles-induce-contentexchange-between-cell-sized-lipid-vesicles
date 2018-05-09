function save_more_parameters(folders2analyse,save_name,collect_n, collect_frames, collect_n_blue, collect_n_red)

fid = fopen(strcat(save_name,'n_detected.txt'),'a');
fprintf(fid, 'data set \t numbers of bacs detected \t number of images analysed \t number of bacs detected in blue channel \t number of bacs detected in red channel \n');
for i = 1:length(collect_n)
    if i==1
        fprintf(fid,'%s\t%f\t%f\t%f\t%f\n',folders2analyse{i},collect_n(i), collect_frames(i), collect_n_blue(i), collect_n_red(i));
    else
        fprintf(fid,'%s\t%f\t%f\t%f\t%f\n','',collect_n(i), collect_frames(i), collect_n_blue(i), collect_n_red(i));
        
    end
end
fclose(fid);
   