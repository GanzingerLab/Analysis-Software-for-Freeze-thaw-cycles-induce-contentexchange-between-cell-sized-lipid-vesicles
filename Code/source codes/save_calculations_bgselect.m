function save_calculations_bgselect(tiff_files,red_channel,green_channel,ratio,label,ncells,save_name,red_bg,blue_bg)
global n
fid = fopen(strcat(save_name,label,'_Stats_beads.txt'),'a');
   if n == 1
   fprintf(fid, '  %s\t    %s\t   %s\t %s\t   %s\t %s\n','filename','Mean Intensity Red Dye corrected','Mean Intensity Green Dye corrected', 'Ratio','Mean Background Red','Mean Background Green');
   end
   for n3=1:ncells
    
    fprintf(fid, '  %s\t   %f\t   %f\t %f\t   %f\t %f\n',tiff_files{n},red_channel(n3),green_channel(n3),ratio(n3),red_bg,blue_bg);
    end    
    fclose(fid);
end
   