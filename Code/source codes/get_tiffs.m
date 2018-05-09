function [red_files,blue_files] = get_tiffs(parameters,stack_directory)

d = dir(stack_directory);

for n=3:length(d),
    % start at 3, skip the first two, irrelevent entries (., ..)
    name = d(n).name;
    isstk= strfind(name,parameters.file_type);
    isblue=findstr(name,'B');
    isred =findstr(name,'R');
    %separate blue and fluorescent TC and FRET files
   
        if (length(isstk) >= 1)
            
                if (isempty(isblue) && ~isempty(isred))
                    index = [str2double(name(1:end-5))];
                    red_files{index} = name;
                    
                elseif (length(isblue) >= 1)
                    index = [str2double(name(1:end-5))];
                    blue_files{index} = name;
                end
        end
       
        
end

end