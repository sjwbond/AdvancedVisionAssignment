function output = remove_points(pc,pc_object)
    
    point = zeros(size(pc.Location));

    for i = 1:size(pc_object)
        if pc_object(i) == 0
            point(i,:) = [nan,nan,nan];
        else
            point(i,:) = pc.Location(i,:);
        end 
    end
    
    output = pointCloud(point, 'Color', pc.Color); % Creating a point-cloud variable
    
end