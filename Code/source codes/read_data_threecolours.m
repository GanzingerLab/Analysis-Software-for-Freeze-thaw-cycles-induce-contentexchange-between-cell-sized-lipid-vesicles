function [both_colours] = read_data_threecolours(directory,file)

 
[im, nImage] = tiffread2(strcat(directory,'\',file));
both_colours = zeros(512,512,nImage);
            
for t=1:nImage
    I = double(im(t).data);
    both_colours(:,:,t) = I;
end
            

end