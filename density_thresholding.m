function output = density_thresholding(pc,pc_object,points,sigma)
    
    closest_points = NaN(size(pc.Location,1),points);
    average_distance = NaN(size(pc.Location,1),1);
    
    output = zeros(size(pc_object));
    rgb = reshape_rgb(pc);
    
    locs = zeros(2,3);
    
     for i = 2:size(rgb,1)-1
        for j = 2:size(rgb,2)-1 
            % is this flagged as part of the object?
            pc_index = (i-1)*size(rgb,2)+j;
            if pc_object(pc_index) == 1
                %look at each surrounding pixel and count if there is a 3d
                %coordinate
                count = 0;
                locs(1,:) = pc.Location(pc_index,:);
                
                for x = -1:1
                    for y = -1:1
                        
                        pc_index2 = (i+x-1)*size(rgb,2)+j+y;
                        if pc_object(pc_index2) == 1
                            if not(isnan(pc.Location(pc_index2,1)))
                                if not(x==0 && y ==0)
                                    count = count +1;
                        
                                    locs(2,:) = pc.Location(pc_index2,:);
                                    closest_points(pc_index,count) = pdist(locs);
                                end                                
                            end
                        else
                            count = count +1;
                            locs(2,:) = [0,0,0];
                            closest_points(pc_index,count) = pdist(locs);
                        end
                    end
                end
                average_distance(pc_index) = mean(closest_points(pc_index,:));
            else
                average_distance(pc_index) = nan;
            end
       
        end
     end
    
     stdev = nanstd(average_distance);
     figure(3);histogram(average_distance);
     
     for i = 1:size(output)
         if pc_object(i) == 1
            if average_distance(i) > stdev * sigma
                output(i) = 0;
            else
                output(i) =1;
            end
         else
             output(i) = 0;
         end
     end
      
end