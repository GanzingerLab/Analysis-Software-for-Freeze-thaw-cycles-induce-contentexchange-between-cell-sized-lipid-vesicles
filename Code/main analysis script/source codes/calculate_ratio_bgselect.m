function [green_channel red_channel ratio] = calculate_ratio_bgselect(blue,red,blue_dye,red_dye,bg_red,bg_blue)

blue_bg_corrected = blue - bg_blue;
red_bg_corrected = red - bg_red;
blue_dye_bg_corrected = blue_dye - bg_blue;
red_dye_bg_corrected = red_dye - bg_red;
    
    
green_channel = blue_bg_corrected./blue_dye_bg_corrected;
red_channel = red_bg_corrected./red_dye_bg_corrected;
ratio = green_channel./(green_channel+red_channel);
end
