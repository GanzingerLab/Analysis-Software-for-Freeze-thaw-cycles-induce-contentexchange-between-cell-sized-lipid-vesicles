function [BW] = createBinaryMask(I_red,I_blue,parameters)
%create binary image with a threshold suitable to differentiate between
%bacteria and background (bacteria = 1, bg =0)

Ifr = bpass(I_red,2,100);
Ifb = bpass(I_blue,2,100);

%used to be mean and std for thresholding...
BWtempb =(Ifb>(mean((Ifb(:))+parameters.binary_thres*mean(Ifb(:)))));
BWtempr =(Ifr>(mean((Ifr(:))+parameters.binary_thres*mean(Ifr(:)))));
BW = or(BWtempb,BWtempr);

%plot results to check threshold settings:

% %figure
% % imagesc(I_blue);truesize
%  figure(10)
%  imagesc(BWtempb);truesize
% % figure
% % imagesc(I_red);truesize
%  figure(11)
%  imagesc(BWtempr);truesize
% % figure
% % imagesc(BWtempb + ((BWtempr)*2));truesize
%  pause




%previous code for OR criterion using only one of the two channels
%temp_b = (I_blue.*BWtempb)-mean(mean(I_blue.*~BWtempb));
%temp_r = (I_red.*BWtempr)-mean(mean(I_red.*~BWtempr));

%if mean(temp_b(temp_b>0)) > mean(temp_r(temp_r>0))
%    BW = BWtempb;
%else
%    BW = BWtempr;
%end

end