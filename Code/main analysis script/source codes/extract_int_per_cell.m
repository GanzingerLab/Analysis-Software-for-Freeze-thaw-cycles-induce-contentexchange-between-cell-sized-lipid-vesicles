function [xyAreaInt,tokeep,sizeBeforeThres,bg] = extract_int_per_cell(varargin)

global n

I = varargin{1};
parameters = varargin{2};
save_dir = varargin{3};
type = varargin{4};

%figure
%imagesc(I), truesize;

if nargin == 5
    BW =  varargin{5};
else
    
    %create binary image with a threshold suitable to differentiate between
    %bacteria and background (bacteria = 1, bg =0)
    If = bpass(I,0,25);
    
    BW =(If>(mean((If(:))+parameters.binary_thres*std(If(:)))));
end

if nargin == 6
    BW =  varargin{5};
    xyAreaInt_red =  varargin{6};
end

if nargin == 7
    BW =  varargin{5};
    xyAreaInt_red =  varargin{6};
    tokeep =  varargin{7};
end
% for experiments with outside dye
BW = imdilate(BW,strel('disk',3));
BW = imerode(BW,strel('disk',5));

if strcmp(type,'r')
bg = mean(mean(I(I>(mean(I(:))+(5*std(I(:)))))));
else
bg = mean(mean(I(I<(mean(I(:))-(2.5*std(I(:)))))));
end

% take only the centre of the vesicle

numPixel = 1;
while numPixel <5
    BW2 = bwperim(BW);
    BW = BW - BW2;
    numPixel = numPixel + 1; 
end


if parameters.display_images == 1 && strcmp(type,'r')
    figure
    imagesc(BW), truesize;
    saveas(gcf,strcat(save_dir,num2str(n),'_mask_',type,'.fig'), 'fig');
    %pause
end



% trace objects (bacteria) as continuous regions of 1's in binary image
L = bwlabel(BW);
RGB = label2rgb(L,'jet','w','shuffle');
[B,~] = bwboundaries(BW,'noholes');
% figure
% imagesc(RGB)


% collect information on these regions



STATS = regionprops(L,I,'Area','MeanIntensity','Centroid','PixelIdxList','Perimeter','FilledImage','Eccentricity');

aINT = cat(1, STATS.MeanIntensity);
aAREA = cat(1, STATS.Area);
aPOS = cat(1, STATS.Centroid);
aAXIS = cat(1, STATS.Perimeter);
ECC= cat(1, STATS.Eccentricity);

% calculate centre of region (- 3px from the edge of the detected region (bacteria))

for i=1:max(L(:))
    %calculate OFF pixel in region:
    tmp = STATS(i).FilledImage;
    OFF(i) = length(tmp(:))-sum(tmp(:));
end

aINTsubBG = aINT; %- bacBG';
%INTsmallerA = centerI';
xyAreaInt = [aPOS aAREA aINT aINTsubBG aAXIS OFF' aAREA/23.23];
sizeBeforeThres = xyAreaInt(:,8);
%xyAreaInt = [aPOS aAREA aINT INTsmallerA aAXIS OFF' aAREA/23.23];
%if strcmp(type,'r')
    %apply different thresholds according to parameter settings
    if parameters.sizethresboolean == 0 && parameters.perithresboolean == 0
        
        tokeep = find(parameters.sizethres < xyAreaInt(:,3) & xyAreaInt(:,3) < parameters.sizethres_upperlimit);% &  xyAreaInt(:,8) < 0.4); %& xyAreaInt(:,7) < parameters.emptypx);
        
    elseif  parameters.sizethresboolean == 1 && parameters.perithresboolean == 0
        
        tokeep = find(parameters.sizethres < xyAreaInt(:,3));%&  xyAreaInt(:,5) > 0 & xyAreaInt(:,7) < parameters.emptypx);
        
    elseif parameters.sizethresboolean == 0 && parameters.perithresboolean == 1
        
        tokeep = find((xyAreaInt(:,6)./xyAreaInt(:,3)) > 0.5 & parameters.sizethres < xyAreaInt(:,3) & xyAreaInt(:,3) < parameters.sizethres_upperlimit  &  xyAreaInt(:,5) > 0 & xyAreaInt(:,7) < parameters.emptypx);
        
    elseif parameters.sizethresboolean == 1 && parameters.perithresboolean == 1
        
        tokeep = find((xyAreaInt(:,6)./xyAreaInt(:,3)) > 0.5 & parameters.sizethres < xyAreaInt(:,3) &  xyAreaInt(:,5) > 0 & xyAreaInt(:,7) < parameters.emptypx);
        
    end
%end
xyAreaInt = xyAreaInt(tokeep,:);

if parameters.display_images == 1 %&& strcmp(type,'r')
    count = 1;
    B2 = cell(1,length(tokeep));
    for i=1:length(tokeep)
        B2{count} = B{tokeep(i)};
        
        count = count +1;
    end
    figure, imagesc(I); hold on;  truesize;colormap('jet');%colormap('gray');
    %colors=['g' 'c' 'm' 'y'];
    %'b' 'r' 
    for k=1:length(B2)
        boundary = B2{k};
        %cidx = mod(k,length(colors))+1;
        plot(boundary(:,2), boundary(:,1),'w','LineWidth',1.5);
            %colors(cidx),'LineWidth',1.5);
        %randomize text position for better visibility
        %rndRow = ceil(length(boundary)/(mod(rand*k,7)+1));
        %col = boundary(rndRow,2); row = boundary(rndRow,1);
        %h = text(col+1, row-1, num2str(xyAreaInt(k,3)));%k,7)));%6)/xyAreaInt(k,3)));
        %set(h,'Color',colors(cidx),...
            %'FontSize',10);%,'FontWeight','bold');
    end
    
    hold off
    saveas(gcf,strcat(save_dir,num2str(n),'_final_',type,'.fig'), 'fig');
    %pause
end


%%code used to generate SI Figure 3
% if strcmp(type,'b')
%     figure
%     for i = 1:length(xyAreaInt)
%
%
%         if i == 21 || i == 29
%             g =  scatter(xyAreaInt_red(i,5),xyAreaInt(i,5),'MarkerEdgeColor','c');
%
%             h = text(xyAreaInt_red(i,5),xyAreaInt(i,5),strcat(' \leftarrow', num2str(i)));
%             set(h,'Color','c',...
%                 'FontSize',10);%,'FontWeight','bold');
%
%         elseif i == 31 || i == 34
%             g =  scatter(xyAreaInt_red(i,5),xyAreaInt(i,5),'MarkerEdgeColor','m');
%
%             h = text(xyAreaInt_red(i,5),xyAreaInt(i,5),strcat(' \leftarrow', num2str(i)));
%             set(h,'Color','m',...
%                 'FontSize',10);%,'FontWeight','bold');
%
%         elseif i == 50 || i == 40
%             g = scatter(xyAreaInt_red(i,5),xyAreaInt(i,5),'MarkerEdgeColor','y');
%
%             h = text(xyAreaInt_red(i,5),xyAreaInt(i,5),strcat(' \leftarrow', num2str(i)));
%             set(h,'Color','y',...
%                 'FontSize',10);%,'FontWeight','bold');
%         else
%             g = scatter(xyAreaInt_red(i,5),xyAreaInt(i,5),'MarkerEdgeColor',[0.3 0.3 0.3]);
%
%         end
%         set(g,'SizeData',100,'LineWidth',2);
%         hold on
%
%
%     end
%     hold off
%     pause
% end



close all

