function [folders2analyse,root_directory] = getfolderstoanalyse(path) 

%root_directory  = uigetdir('','Choose directory containing image files');
%root_directory = '\\Klenerman-fileserver.ch.cam.ac.uk\klenerman$\shared\Rohan Ranasinghe\MATLAB\version9--debugging\LOD Experiments\Day 3\Data\';
root_directory = path;
d = dir(root_directory);
count = 1;

for n=1:length(d),
    % start at 3, skip the first two, irrelevent entries (., ..)
    
    if strcmp(d(n).name,'.') ~= 1 && strcmp(d(n).name,'..')~= 1 && d(n).isdir == 1 
    folders2analyse{count} = d(n).name;   
    count = count +1;
    end
    
end


end