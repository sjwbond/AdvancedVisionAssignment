function output = RGB_with_Object(pc,pc_object)
    
    rgb = pc.Color;
    rgb_New = uint8(zeros(size(rgb)));
    
    for i = 1:pc.Count
        if pc_object(i) == 1
           rgb_New(i,:) = rgb(i,:);
        else
           rgb_New(i,:) = [nan,nan,nan];
        end
    end

    rec_r = reshape(rgb_New(:,1), [512, 424]);
    rec_g = reshape(rgb_New(:,2), [512, 424]);
    rec_b = reshape(rgb_New(:,3), [512, 424]);
    output = cat(3, rec_r', rec_g', rec_b');
   
end