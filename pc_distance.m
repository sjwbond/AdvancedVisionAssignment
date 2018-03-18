function output = pc_distance(pc, rgb, objectPoint, sigma, isObject)
    
    output = isObject;
    distance = zeros(size(pc,1),1);
    x = zeros(2,3);
    x(2,:) = objectPoint;
            
    for i = 1:size(pc,1)
        if isnan(pc(i,1)) == 0
            if isObject(i) == 1
                x(1,:) = pc(i,:);
                distance(i) = pdist(x); %norm(pc.Location, objectPoint);
                output(i) = 1;
            end
        else
            output(i) = 0;
        end
    end
    
    stdev = std(distance);
    stdLimit = stdev * double(sigma);
    
    thresholded = uint8(zeros(size(rgb)));
    
    for i = 1:size(pc,1)
        
        if output(i) == 1 && distance(i) < stdLimit
            thresholded(i,:) = rgb(i,:);
        else
            output(i) = 0;
            thresholded(i,:) = [nan,nan,nan];
        end
       
    end
    
    %figure(1);
    %imag2d(thresholded);
    
end
