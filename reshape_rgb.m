function output = reshape_rgb(pc)
  
    color_pc = pc.Color;

    %% Extracting the r, g, b colours
    r = color_pc(:,1);
    g = color_pc(:,2);
    b = color_pc(:,3);

    %% reshaping each array (r, g, b) to obtain a [512x424] matrix 
    rec_r = reshape(r, [512, 424]);
    rec_g = reshape(g, [512, 424]);
    rec_b = reshape(b, [512, 424]);
    output = cat(3, rec_r', rec_g', rec_b');
    
end
