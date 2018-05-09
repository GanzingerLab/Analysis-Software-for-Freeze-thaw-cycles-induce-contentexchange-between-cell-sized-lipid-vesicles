function [both_colours] = read_data(directory,file)

 
[im, nImage] = tiffread2(strcat(directory,'/',file));
both_colours = zeros(size(im(1).data,1),size(im(1).data,2),nImage);
            
for t=1:nImage,
    I = double(im(t).data);
    both_colours(:,:,t) = I;
end
            

end