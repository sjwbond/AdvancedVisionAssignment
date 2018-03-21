function output = getdistancetoallotherpoints(pcl,IDs)
    %this is slow you can optimise it
    output = zeros(size(IDs,1),1);

    for i = 1:size(IDs,1)
        
        pnt = pcl(IDs(i),:);
        dist = 0;
        
        for j = 1:size(IDs,1)
            dist = dist + norm(pcl(IDs(j),:) - pnt);
        end
        
        output(i) = dist/size(IDs,1);
    
    end
    

end