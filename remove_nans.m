function [pc, idx] = remove_nans(pcl)
    
    id = 0;
    for i = 1: size(pcl,1)
        if isnan(pcl(i,1)) == 0
           id = id + 1;
           pc(id,1) = pcl(i,1);
           pc(id,2) = pcl(i,2);
           pc(id,3) = pcl(i,3);
           idx(id,1) = i;
        end
    end

end