function [isbatch,path] = run_batch
qstring = 'Run Batch version?';
choice = questdlg(qstring,'Mode of Program',...
    'Yes','No','Yes');
switch choice
    case 'Yes'
        isbatch = 1;
        
        prompt={'Please enter full path to data directory:'};
        defans = {'/Users/kristina/Desktop/FT project Thomas/data/dye exp'};
        info = inputdlg(prompt,'path',1,defans);
        path = info{1};
        
    case 'No'
        isbatch = 0;
        path = 0;
end