function make_tiff(filename,video,nImage)
%filename = strcat(filename,'_filtered');
imwrite(uint16(video(:,:,1)),filename,'compression','none');

if nImage>1,

    for ii = 2:nImage,

        imwrite(uint16(video(:,:,ii)),filename,'compression','none','writemode','append');

    end

end