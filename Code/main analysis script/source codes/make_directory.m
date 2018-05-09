function [save_name,fig_name,batchsave]= make_directory(exp_name,currentfolder,batchsave,loc4dir)
global n2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This first part creates a directory for saving the data. The program will
% not overwrite existing folders, but will instead create a new version
% with a numbered suffix.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

directory_name = strcat(loc4dir,'\',exp_name,'_results');
if n2 ==1
    if isdir(directory_name)~=1,
        if ischar(currentfolder)
            directory_name = strcat(loc4dir,'\',exp_name,'_results\',currentfolder);
            batchsave = strcat(loc4dir,'\',exp_name,'_results');
        end
        
        mkdir(directory_name);
        save_name = strcat(directory_name,'\');
        fig_name = strcat(directory_name,'\');
        
    else
        count = 1;
        indicator = 1;
        while indicator ==1,
            if isdir(strcat(directory_name,'_',num2str(count)))==1,
                count = count + 1;
            else
                
                if ischar(currentfolder)
                    save_directory = strcat(directory_name,'_',num2str(count),'\',currentfolder);
                    batchsave = strcat(directory_name,'_',num2str(count));
                else
                    save_directory = strcat(directory_name,'_',num2str(count));
                end
                
                mkdir(save_directory);
                save_name = strcat(save_directory,'\');
                fig_name = strcat(save_directory,'\');
                indicator = 0;
            end
        end
        
    end
else
    
    directory_name = strcat(batchsave,'\',currentfolder);
    mkdir(directory_name);
    save_name = strcat(directory_name,'\');
    fig_name = strcat(directory_name,'\');
    
end



