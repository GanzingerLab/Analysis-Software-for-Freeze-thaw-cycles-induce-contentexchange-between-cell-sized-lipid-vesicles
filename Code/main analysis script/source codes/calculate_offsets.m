function [parameters,offset,offset_turn] = calculate_offsets(parameters,stacks_directory,red_files,blue_files,Lstack)
% Calculate offset to the two imaging channels by using a cross-correlation
% function
%
% median results of successful cross-correlations is saved/applied if cross-correlation fails for an image pair 
%
% uncomment the following line and change index n0 to r for a random sub-sampling of images which the offset 
% should be calculated from:
%
% r = round((Lstack-1).*rand(round(Lstack/3),1) + 1);
%
% also change Lstack (line 18) to round(Lstack/3)
 
clear offset
 offset = ones(Lstack,2)*-1000;
 offset_turn = ones(Lstack,2)*-1000;
 
 for n0 = 1:Lstack 
     
        if  ~isempty(red_files{n0}) && rem(n0,parameters.consecutive_images)
            
             
            [both_colours_red] = read_data(stacks_directory,red_files{n0});
            [both_colours_blue] = read_data(stacks_directory,blue_files{n0});
           
            [red_temp,~] = select_region_fullchip(both_colours_red,parameters.image_width,1);
            [~,blue_temp] = select_region_fullchip(both_colours_blue,parameters.image_width,1);
            
          
            [offset(n0,1:2)] = select_region_auto_shiftcorr_optionalBAC_foroffset(red_temp,blue_temp,parameters);   
        elseif ~isempty(red_files{n0})
            [both_colours_red] = read_data(stacks_directory,red_files{n0});
            [both_colours_blue] = read_data(stacks_directory,blue_files{n0});
           
            [red_temp,~] = select_region_fullchip(both_colours_red,parameters.image_width,1);
            [~,blue_temp] = select_region_fullchip(both_colours_blue,parameters.image_width,1);
            
          
            [offset_turn(n0,1:2)] = select_region_auto_shiftcorr_optionalBAC_foroffset(red_temp,blue_temp,parameters); 
        end
    
 end
 
 %calculate mean for consecutive images
 offset1 = offset(:,1);
 meanoffset1 = median(offset1(abs(offset1)<50));
 offset2 = offset(:,2);
 meanoffset2 = median(offset2(abs(offset2)<50));
 
 %calculate mean at turn  of imaging sequence
 offset1 = offset_turn(:,1);
 meanoffsetturn1 = median(offset1(abs(offset1)<50));
 offset2 = offset_turn(:,2);
 meanoffsetturn2 = median(offset2(abs(offset2)<50));
 
 temp = zeros(size(offset,1),2);
 for i=1:size(offset,1)
     
     if abs(offset(i,1))<50 && abs(offset(i,2))<50
         temp(i,:) = offset(i,:);
         
     elseif sum(offset(i,:)) == -2000
         
         if abs(offset_turn(i,1))<50 && abs(offset_turn(i,2))<50
             temp(i,:) = offset_turn(i,:);
         else
             %this set of if causes means that if there is no image, offset
             %is set to [meanoffsetturn1 meanoffsetturn2] but this does not
             %matter since these entries are skipped in the later script
             %anyway
             
             temp(i,:) = [meanoffsetturn1 meanoffsetturn2];
         end
         
     else
         
         temp(i,:) = [meanoffset1 meanoffset2];
     
     end
 end
  
 parameters.offset = temp;

 

end

