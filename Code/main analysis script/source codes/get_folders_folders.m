function [list_dir,folders11,folders1,folders,samplename] = get_folders_folders(directory)

d = dir(directory);

ii = 1;

for n = 3:length(d),
    if d(n).isdir == 1,
        a = d(n).name;
        folders11{ii} = d(n).name;
        list_dir11{ii} = strcat(directory,'\',d(n).name);
        ii = ii + 1;
        
    end
    
end

%get subfolders with sample
for n = 1 : size(list_dir11,2)
    current_directory = list_dir11{n};
    [list_dir1_temp{n},folders1_temp{n}] = get_folders_withdirectory('sample',current_directory);
end

%form list to look for subfolders
ii=1;
for n = 1 : size(list_dir1_temp,2)
    temp = list_dir1_temp{n};
    temp_f = folders1_temp{n};
    for nn = 1:size(temp,2)
        temp2=temp{nn};
        temp_f2=temp_f{nn};
        list_dir1{ii}=temp2;
        folders1{ii}=temp_f2;
        samplename{ii}=strcat(folders11{n},'_',temp_f2);
        ii=ii+1;

    end
end
        
        
    

%getsubsubfolders with c
for n = 1 : size(list_dir1,2)
    current_directory = list_dir1{n};
    [list_dir{n},folders{n}] = get_folders_withdirectory('c',current_directory);
end


function [list_dir,folders] = get_folders_withdirectory(keyword,current_directory)

d = dir(current_directory);

ii = 1;

for n = 3:length(d),

    if d(n).isdir == 1,
        
        a = d(n).name;
        if findstr(a,keyword) >= 1,
            folders{ii} = d(n).name;
            list_dir{ii} = strcat(current_directory,'\',d(n).name);
            ii = ii + 1;

        end
        
    end
    
end




