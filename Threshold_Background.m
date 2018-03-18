function output = Threshold_Background(pc,bg)

    bg_hsv = rgb2hsv(bg);
    
    rec_r = reshape(pc.Color(:,1), [512, 424]);
    rec_g = reshape(pc.Color(:,2), [512, 424]);
    rec_b = reshape(pc.Color(:,3), [512, 424]);
    img_rgb = cat(3, rec_r', rec_g', rec_b');
    
    img_hsv = rgb2hsv(img_rgb);
    
    img_hsv_sub = imsubtract(img_hsv,bg_hsv);
    img_h_sub = img_hsv_sub(:,:,1)
    figure(300)
    imshow(img_h_sub)
        
    isBox = zeros(size(abs_errors(:,1)));
    
    %figure(); histogram(errors(:,1),500);
    %figure(); histogram(errors(:,2),500);
    %figure(); histogram(errors(:,3),500);
    
    rec_r = reshape(abs_errors(:,1), [512, 424]);
    rec_g = reshape(abs_errors(:,2), [512, 424]);
    rec_b = reshape(abs_errors(:,3), [512, 424]);
    new_abs = cat(3, rec_r', rec_g', rec_b');
    
    rec_r = reshape(rel_r, [512, 424]);
    rec_g = reshape(rel_g, [512, 424]);
    rec_b = reshape(rel_b, [512, 424]);
    new_rel = cat(3, rec_r', rec_g', rec_b');

    
    imshow(new_abs);
    imshow(new_rel);
    
    for i = 1:pc.Count
    
        if errors(i,1) > 0 || errors(i,2) > 0 || errors(i,3) > 0 
            isBox(i) = 255;
        else
            isBox(i) = 0;
        end
        
    end
    
    output = int32(isBox);
    
end