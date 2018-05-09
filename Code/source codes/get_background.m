function bg = get_background(im,type)


region4background = 20;


if strcmp(type,'r') == 1
temp4Background = [im(1:region4background, :); im(256-region4background:256, :)];
else
temp4Background = [im(257:region4background, :); im(512-region4background:512, :)];
end


Background = temp4Background(find(temp4Background>0));
median4BN = median(reshape(Background, prod(size(Background)), 1));
iqr4BN = iqr(reshape(Background, prod(size(Background)), 1));
Background2 = Background(find(Background<(median4BN+(2*iqr4BN))));


bg = mean(reshape(Background2, prod(size(Background2)), 1));
end