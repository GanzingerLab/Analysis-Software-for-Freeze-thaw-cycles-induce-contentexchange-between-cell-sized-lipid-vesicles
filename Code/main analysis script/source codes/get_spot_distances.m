function [matched_points,coloc_positions] = get_spot_distances(varargin)

red_spots_41cell = varargin{1};
blue_spots_41cell = varargin{2};
parameters = varargin{3};
number_of_spots41cell = varargin{4};

%figure
%imagesc(I), truesize;

if nargin == 5
   colour =  varargin{5};
else
colour = 'b';
end

matched_points = zeros(parameters.maxD,1);
coloc_positions = cell(parameters.maxD,1);

for d = 1:parameters.maxD,
    
    d_lim = d.*(parameters.distance_bin./parameters.pixel_size);
%    d_lim = d;
    
    [matched_points(d),coloc_positions{d}] = get_matched_spots(red_spots_41cell,blue_spots_41cell,number_of_spots41cell,d_lim,colour);

        
end