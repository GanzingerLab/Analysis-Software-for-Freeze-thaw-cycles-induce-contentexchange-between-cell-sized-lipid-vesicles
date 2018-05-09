function [offset] = select_region_auto_shiftcorr_optionalBAC_foroffset(i_red,i_blue,parameters)


if parameters.offsetcorr == 1
    image_red = bpass(i_red,1,7);
    image_blue = bpass(i_blue,1,7);
    
    cc_template = image_blue(125:275,50:200);
    
    C = normxcorr2(cc_template,image_red);
    C2 = normxcorr2(cc_template,image_blue);
    
    [~, imax] = max(abs(C(:)));
    [ypeak_r, xpeak_r] = ind2sub(size(C),imax(1));
    
    [~, imax_b] = max(abs(C2(:)));
    [ypeak_b, xpeak_b] = ind2sub(size(C2),imax_b(1));
    
    offset = [ypeak_b-ypeak_r xpeak_b-xpeak_r];
    
%elseif parameters.offsetcorr == 2
    
%    offset = parameters.offset;
end

% if parameters.offsetcorr == 2 || parameters.offsetcorr == 1
%     
%     
%     [image_blue_shifted,image_red_shifted] = get_shifted_image(i_blue,i_red,offset);
%     
%     r_start = 10;
%     r_end = size(image_red_shifted,1)-10;
%     c_start = 10;
%     c_end = size(image_red_shifted,2)-10;
%     
%     if ~isempty(image_blue_shifted)
%         for i = 1:nImage
%             b(:,:,i) = image_blue_shifted(r_start:r_end,c_start:c_end,i);
%             r(:,:,i) = image_red_shifted(r_start:r_end,c_start:c_end,i);
%         end
%         
%        
%         
%         start_point_cell = r_end-r_start;
%     else
%         
%         b=[];
%         r = [];  
%       
%         start_point_cell = -1;
%         
%     end
%     
% else
%     r_start = 30;
%     r_end = 480;
%     c_start = 15;
%     c_end = 250;
%     
%     for i = 1:nImage
%             b(:,:,i) = i_blue(r_start:r_end,c_start:c_end,i);
%             r(:,:,i) = i_red(r_start:r_end,c_start:c_end,i);
%           
%     end
%     
%      start_point_cell = r_end-r_start;
% end
% 
% end

% 
% 
% function [image_blue_shifted,image_red_shifted] = get_shifted_image(i_b,i_r,offset)
% if abs(offset(1)) < 50 && abs(offset(2)) <50 
%     
%     if offset(1) >0 && offset(2)>0
%         image_blue_shifted = i_b;
%         image_blue_shifted(1:offset(1),:)=[];
%         image_blue_shifted(:,1:offset(2))=[];
%         
%         image_red_shifted = i_r(1:end-offset(1),1:end-offset(2));
%         
%     elseif offset(1) <0 && offset(2)<0
%         offset(1) = -offset(1);
%         offset(2) = -offset(2);
%         image_red_shifted = i_r;
%         image_red_shifted(1:offset(1),:)=[];
%         image_red_shifted(:,1:offset(2))=[];
%         
%         image_blue_shifted = i_b(1:end-offset(1),1:end-offset(2));
%         
%     elseif offset(1) >0 && offset(2)<0
%         
%         offset(2) = -offset(2);
%         image_red_shifted = i_r;
%         image_red_shifted(end-offset(1)+1:end,:)=[];
%         image_red_shifted(:,1:offset(2))=[];
%         
%         image_blue_shifted = i_b(offset(1)+1:end,1:end-offset(2));
%         
%         
%     elseif offset(1) <0 && offset(2)>0
%         offset(1) = -offset(1);
%         image_red_shifted = i_r;
%         image_red_shifted(1:offset(1),:)=[];
%         image_red_shifted(:,end-offset(2)+1:end)=[];
%         
%         image_blue_shifted = i_b(1:end-offset(1),offset(2)+1:end);
%         
%     elseif offset(1) <0 && offset(2)==0
%         offset(1) = -offset(1);
%         image_red_shifted = i_r;
%         image_red_shifted(1:offset(1),:)=[];
%         image_blue_shifted = i_b(1:end-offset(1),:);
%         
%     elseif offset(1) >0 && offset(2)==0
%         
%         offset(2) = -offset(2);
%         image_red_shifted = i_r;
%         image_red_shifted(end-offset(1)+1:end,:)=[];
%         image_blue_shifted = i_b(offset(1)+1:end,:);
%         
%     elseif offset(1) ==0 && offset(2)>0
%        
%         image_red_shifted = i_r;
%         image_red_shifted(:,end-offset(2)+1:end)=[];
%         image_blue_shifted = i_b(:,offset(2)+1:end);
%         
%     elseif offset(1) ==0 && offset(2)<0
%         
%        offset(2) = -offset(2);
%        image_red_shifted = i_r;
%        image_red_shifted(:,1:offset(2))=[];
%        image_blue_shifted = i_b(:,1:end-offset(2));
%         
%         
%         
%     end
%     
% else
%     
%     image_red_shifted=[];
%     
%     image_blue_shifted =[];
%     
% end
% 
% 
% end
