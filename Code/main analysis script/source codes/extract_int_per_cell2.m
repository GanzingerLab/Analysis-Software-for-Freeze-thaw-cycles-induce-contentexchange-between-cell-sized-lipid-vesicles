function [xyAreaInt] = extract_int_per_cell2(varargin)

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
if parameters.display_images == 1 && strcmp(type,'r')
    figure
    imagesc(BW), truesize;
    saveas(gcf,strcat(save_dir,num2str(n),'_mask_',type,'.fig'), 'fig');
    pause
end

% trace objects (bacteria) as continuous regions of 1's in binary image
L = bwlabel(BW);
RGB = label2rgb(L,'jet','w','shuffle');
[B,~] = bwboundaries(BW,'noholes');
% figure
% imagesc(RGB)

% collect information on these regions
STATS = regionprops(L,I,'Area','MeanIntensity','Centroid','PixelIdxList','Perimeter','FilledImage','PixelValues','Eccentricity');

aINT = cat(1, STATS.MeanIntensity);
aAREA = cat(1, STATS.Area);
aPOS = cat(1, STATS.Centroid);
aAXIS = cat(1, STATS.Perimeter);
Ecc = cat(1, STATS.Eccentricity);
% calculate local bg from region (+/- 3px from the edge of the detected region (bacteria))

for i=1:max(L(:))
    cur_bac = STATS(i).PixelIdxList;
    
    [r, c] = ind2sub(size(BW),cur_bac);
    
    temp_l = [r, c-3];
    temp_r = [r, c+3];
    
    temp_l = temp_l(temp_l(:,2)>0,:);
    temp_l = temp_l(temp_l(:,2)<size(BW,2),:);
    
    temp_r = temp_r(temp_r(:,2)>0,:);
    temp_r = temp_r(temp_r(:,2)<size(BW,2),:);
    
    shiftleft = sub2ind(size(BW),temp_l(:,1),temp_l(:,2));
    shiftright = sub2ind(size(BW),temp_r(:,1),temp_r(:,2));
    
    for ii=1:length(cur_bac)
        shiftleft(shiftleft==cur_bac(ii))=[];
        shiftright(shiftright==cur_bac(ii))=[];
    end
    
    bacBG(i) = mean(I([shiftleft; shiftright]));
    
    %calculate OFF pixel in region:
    tmp = STATS(i).FilledImage;
    OFF(i) = length(tmp(:))-sum(tmp(:));
    %calculate standard deviation
    tmp2 = STATS(i).PixelValues;
    Int_var(i) = std(tmp2);
end

aINTsubBG = aINT - bacBG';

xyAreaInt = [aPOS aAREA aINT aINTsubBG aAXIS OFF' Int_var' Ecc];

%apply different thresholds according to parameter settings
if parameters.sizethresboolean == 0 && parameters.perithresboolean == 0
    
    tokeep = find(parameters.sizethres < xyAreaInt(:,3) & xyAreaInt(:,3) < parameters.sizethres_upperlimit  &  xyAreaInt(:,5) > 0 & xyAreaInt(:,7) < parameters.emptypx);
    
elseif  parameters.sizethresboolean == 1 && parameters.perithresboolean == 0
    
    tokeep = find(parameters.sizethres < xyAreaInt(:,3) &  xyAreaInt(:,5) > 0 & xyAreaInt(:,7) < parameters.emptypx);
    
elseif parameters.sizethresboolean == 0 && parameters.perithresboolean == 1
    
    tokeep = find((xyAreaInt(:,6)./xyAreaInt(:,3)) > 0.5 & parameters.sizethres < xyAreaInt(:,3) & xyAreaInt(:,3) < parameters.sizethres_upperlimit  &  xyAreaInt(:,5) > 0 & xyAreaInt(:,7) < parameters.emptypx);
    
elseif parameters.sizethresboolean == 1 && parameters.perithresboolean == 1
    
    tokeep = find((xyAreaInt(:,6)./xyAreaInt(:,3)) > 0.5 & parameters.sizethres < xyAreaInt(:,3) &  xyAreaInt(:,5) > 0 & xyAreaInt(:,7) < parameters.emptypx);
    
end

xyAreaInt = xyAreaInt(tokeep,:);

%xyAreaInt = xyAreaInt(xyAreaInt(:,9) > 0.7,:);

if parameters.display_images == 1 && strcmp(type,'r')
    count = 1;
    B2 = cell(1,length(tokeep));
    for i=1:length(tokeep)
        B2{count} = B{tokeep(i)};
        
        count = count +1;
    end
    figure, imagesc(BW); hold on; colormap('gray'); truesize;
    colors=['b' 'g' 'r' 'c' 'm' 'y'];
    
    for k=1:length(B2)
        boundary = B2{k};
        cidx = mod(k,length(colors))+1;
        plot(boundary(:,2), boundary(:,1),...
            colors(cidx),'LineWidth',1.5);
        %randomize text position for better visibility
        rndRow = ceil(length(boundary)/(mod(rand*k,7)+1));
        col = boundary(rndRow,2); row = boundary(rndRow,1);
        h = text(col+1, row-1, num2str(xyAreaInt(k,9)));%xyAreaInt(k,8)));%(k));%k,7)));%6)/xyAreaInt(k,3)));
        set(h,'Color',colors(cidx),...
            'FontSize',10);%,'FontWeight','bold');
    end
    
    hold off
    saveas(gcf,strcat(save_dir,num2str(n),'_final_',type,'.fig'), 'fig');
    pause
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

