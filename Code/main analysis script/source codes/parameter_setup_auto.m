function [parameters] = parameter_setup_auto(parameters)

switch parameters.objective
    case 1 %'20x NA0.5'     
        parameters.pixel_size = 321;   
        parameters.emptypx = 50;
        %parameters.sizethres = 10;
        %parameters.sizethres_upperlimit = 100;
    case 2 %'20x NA0.75'
        parameters.pixel_size = 321;
        parameters.emptypx = 50;
        %parameters.sizethres = 10;
    case 3 %'40x NA0.95'
        parameters.pixel_size = 161;
        parameters.emptypx = 200;
        %parameters.sizethres = 50
        %parameters.sizethres_upperlimit = 500;
    case 4 %'60x NA0.95'
        parameters.pixel_size = 107;
        parameters.emptypx = 450;
        %parameters.sizethres = 75;
    case 5 %'60x NA1.4'
        parameters.pixel_size = 107;
        parameters.emptypx = 450;
        %parameters.sizethres = 90;
        %parameters.sizethres_upperlimit = 500;
    case 6 %'60x NA1.49'
        parameters.pixel_size = 132;
        parameters.emptypx = 450;
        %parameters.sizethres = 90;
        %parameters.sizethres_upperlimit = 500;
end   
parameters.consecutive_images = 1;
parameters.file_type= '.tif';
parameters.image_width=256;
%parameters for colocalisation step
parameters.distance_bin = 100;  %bin (dist) of colocalisation histogram
parameters.maxD = 15;           %number of bins of colocalisation histogram
parameters.coloc_criterion =3*parameters.pixel_size; %distance threshold for colocalisation
parameters.coloc_bin = round(parameters.coloc_criterion/parameters.distance_bin); %number of bin

%% prompt for offset values if fixed offset correction is desired (as of first GUI)
if parameters.offsetcorr == 2
    prompt={'offset (y)'...
        'offset (x)'};
    setup.defans={'-1'...
        '28'};
    info = inputdlg(prompt, 'Fixed offset values:', 1, setup.defans,'on');
    parameters.offset = [str2double(info{1}) str2double(info{2})];
end


end