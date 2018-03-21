function [pcout,objectIDs] = remove_points_IDs(pc,pc_object)
    
    point = zeros(size(pc.Location));
    objectCount = 0;
    
    
    for i = 1:size(pc_object)
        
        if pc_object(i) == 0
            point(i,:) = [nan,nan,nan];
        else
            point(i,:) = pc.Location(i,:);
            objectCount = objectCount + 1;
            objectIDs(objectCount,1) = i;
        end 
    end
    
    pcout = pointCloud(point, 'Color', pc.Color); % Creating a point-cloud variable
    
end