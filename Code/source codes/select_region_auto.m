function [b,r, x_start, x_end, y_start, y_end, start_point_cell] = select_region_auto(image_current,image_width,nImage)

% [xx yy]=ginput(2);
 
 x_start = 15;
 x_end = 250;
 y_start = 30;
 y_end = 480;
for i = 1:nImage
if x_end<=image_width, 
    b(:,:,i) = image_current(y_start:y_end,x_start:x_end,i);
    r(:,:,i) = image_current(y_start:y_end,x_start+image_width:x_end+image_width,i);
else
    r(:,:,i) = image_current(y_start:y_end,x_start:x_end,i);
    b(:,:,i) = image_current(y_start:y_end,x_start-image_width:x_end-image_width,i);
end
end
start_point_cell = x_end-x_start;