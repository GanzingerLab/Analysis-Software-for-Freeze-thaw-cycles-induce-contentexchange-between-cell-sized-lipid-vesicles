function [b,r] = select_region_fullchip(image_current,image_width,nImage)

% [xx yy]=ginput(2);
 
 x_start = 1;
 x_end = 256;
 y_start = 1;
 y_end = 512;
for i = 1:nImage
if x_end<=image_width, 
    b(:,:,i) = image_current(y_start:y_end,x_start:x_end,i);
    r(:,:,i) = image_current(y_start:y_end,x_start+image_width:x_end+image_width,i);
else
    r(:,:,i) = image_current(y_start:y_end,x_start:x_end,i);
    b(:,:,i) = image_current(y_start:y_end,x_start-image_width:x_end-image_width,i);
end
end
%start_point_cell = x_end-x_start;