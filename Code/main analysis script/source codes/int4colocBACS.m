function [redint, blueint] = int4colocBACS(pos,sp_red,sp_blue)
%pos = coloc_pos{n,n4}{3,1};
%sp = spots{n,n4};

allindex = [];
allindex_blue = [];

    if ~isempty(pos) == 1
        
        for i = 1:size(pos,1)
            index1 = find(pos(i,3)== sp_red(:,1));
            index2 = find(pos(i,4)== sp_red(:,2));
            index3 = find(pos(i,1)== sp_blue(:,1));
            index4 = find(pos(i,2)== sp_blue(:,2));
            
            for ii = 1:length(index1)
                for iii = 1:length(index2)
                    if index1(ii)==index2(iii)
                        allindex = [allindex index1(ii)];
                    end
                end
            end
            for ii = 1:length(index3)
                for iii = 1:length(index4)
                    if index3(ii)==index4(iii)
                        allindex_blue = [allindex_blue index3(ii)];
                    end
                end
            end
        end
        redint = sp_red(allindex,5);
        blueint = sp_blue(allindex_blue,5);
        
       
        
    else
        redint = [];
        blueint = [];
        
    end
