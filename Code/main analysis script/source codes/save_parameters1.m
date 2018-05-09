function save_parameters1(parameters,save_dir)

fid = fopen(strcat(save_dir,'\_parameters.dat'),'w');

fprintf(fid, 'Parameters\n');
fprintf(fid, 'Minimum length\t%f\n',parameters.minLength);
fprintf(fid, 'Initial Threshold\t%f\n',parameters.initialthreshold);
fprintf(fid, 'Max pixel step between frames\t%f\n',parameters.max_step);
fprintf(fid, 'Bpass parameter lnoise\t%f\n',parameters.lnoise);
fprintf(fid, 'Bpass parameter lobject\t%f\n',parameters.lobject);
fprintf(fid, 'SNR threshold\t%f\n',parameters.SNR);
fprintf(fid, 'memory\t%f\n',parameters.memory);
fprintf(fid, 'Pkfnd parameter\t%f\n',parameters.pkfnd_sz);
fprintf(fid, 'Cntrd parameter\t%f\n',parameters.cntrd_sz);


fclose(fid);