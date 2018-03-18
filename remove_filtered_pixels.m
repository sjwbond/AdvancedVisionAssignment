function output = remove_filtered_pixels(rgb, pc_object)
    
    thresholded = uint8(zeros(size(rgb)));
    
    for i = 1:size(rgb,1)
        for j = 1:size(rgb,2)
            if pc_object((i-1)*size(rgb,2)+j) == 1
                thresholded(i,j,:) = rgb(i,j,:);
            else
                thresholded(i,j,:) = [nan,nan,nan];
            end
        end
    end

    figure(3);
    imshow(thresholded);
    output = 1;
    
end