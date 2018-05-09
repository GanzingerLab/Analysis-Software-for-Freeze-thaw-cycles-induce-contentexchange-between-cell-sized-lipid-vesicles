function [total_coloc_events,coloc_events,coloc_mean,coloc_std,coincidence_blue, coincidence_red] = form_histogram_coloc(coloc_spots,parameters,Lstack,red_spot_index,blue_spot_index)


maxD = parameters.maxD;
total_coloc_events = zeros(maxD,1);
coloc_events = ones(maxD,Lstack)*-1;
   
coincidence_blue = cell(maxD,1);
coincidence_red = cell(maxD,1);


for d=1:maxD,
count = 1;    
coincidence_blue{d} = ones(Lstack)*-1;
coincidence_red{d} = ones(Lstack)*-1;

    for s=1:Lstack,
       
        if ~isempty(coloc_spots{s})
           if coloc_spots{s}(d)>-1
           coloc_event = coloc_spots{s}(d);        
           total_coloc_events(d) = total_coloc_events(d) + coloc_event;
           coloc_events(d,count) = coloc_event;
           
           if blue_spot_index(s) >0,              
           co_blue = 100.*(coloc_event/blue_spot_index(s));
           else
           co_blue = -1;
           end
           if red_spot_index(s) >0,
           co_red = 100.*(coloc_event/red_spot_index(s));
           else
           co_red = -1;
           end
           
           if co_blue <= 100
           coincidence_blue{d}(s) = co_blue;
           else 
           coincidence_blue{d}(s) = 100;
           end
           
           if co_red <= 100,
           coincidence_red{d}(s) = co_red;
           else 
           coincidence_red{d}(s) = 100;
           end
           
           count = count + 1;
        
           end  
        
        end
    end   
        
    [coincidence_blue_vector] = reshape(coincidence_blue{d}, [], 1);
    [coincidence_red_vector] = reshape(coincidence_red{d}, [], 1);
   
    coincidence_blue_vector(coincidence_blue_vector==-1) = [];
    coincidence_red_vector(coincidence_red_vector==-1) = [];
    coloc_mean(d).blue = mean(coincidence_blue_vector);
    coloc_mean(d).red = mean(coincidence_red_vector);
    
    if length(coincidence_blue_vector)>2
    coloc_std(d).blue = std(coincidence_blue_vector);
    coloc_std(d).red = std(coincidence_red_vector);
    else
    coloc_std(d).blue = 0;
    coloc_std(d).red = 0;
    end
    
    
end