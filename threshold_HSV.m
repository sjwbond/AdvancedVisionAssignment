function output = threshold_HSV(pc, pc_object)
    
    output = pc_object;
    
    h_bound = [0.01,0.075];
    s_bound = [0.2,0.8];
    v_bound = [0.2,0.5];
    
    rgb = reshape_rgb(pc);
    
    hsv = rgb2hsv(rgb);
    
    for i = 1:size(rgb,1)
        for j = 1:size(rgb,2)
            if output((i-1)*size(rgb,2)+j) == 1
                if hsv(i,j,1) > h_bound(1) && hsv(i,j,1) < h_bound(2)
                    if hsv(i,j,2) > s_bound(1) && hsv(i,j,2) < s_bound(2)
                        if hsv(i,j,3) > v_bound(1) && hsv(i,j,3) < v_bound(2)
                            output((i-1)*size(rgb,2)+j) = 0;
                        end
                    end     
                end
            end
        end
    end
    
    remove_filtered_pixels(rgb,output);
    %figure(3);histogram(h);
    
end
