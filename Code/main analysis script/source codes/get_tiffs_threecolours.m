function [red_files,blue_files,yellow_files] = get_tiffs_threecolours(parameters,stack_directory)

d = dir(stack_directory);

for n=3:length(d)
    % start at 3, skip the first two, irrelevent entries (., ..)
    name = d(n).name;
    isstk= strfind(name,parameters.file_type);
    
    isblue=strfind(name,'B');
    isred =strfind(name,'R');
    isyellow=strfind(name,'Y');
    
        if (length(isstk) >= 1)
            
                if  isempty(isblue) && ~isempty(isred)
                    index = str2double(name(1:end-5));
                    red_files{index} = name;
                    
                elseif (length(isblue) >= 1)
                    index = str2double(name(1:end-5));
                    blue_files{index} = name;
                elseif ~isempty(isyellow)
                    index = str2double(name(1:end-5));
                    yellow_files{index} = name;
                end
            
        end
        
end

end