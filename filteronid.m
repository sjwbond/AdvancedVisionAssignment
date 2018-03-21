function output = filteronid(pcl,objectIDs)
    
    output = zeros(size(objectIDs,2),3);
    
    for i = 1:size(objectIDs,2)
        output(i,:) = pcl(objectIDs(1,i),:);
    end
    
end