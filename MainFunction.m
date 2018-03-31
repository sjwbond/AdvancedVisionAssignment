%Main stem for the program
%==================================================================

%% For each frame extract the box from the depth data.
box = load('assignment_1_box.mat');
box = box.pcl_train;

for frameNum = 1:50   
%for frameNum = [6,9,12,15,18,21,22,24,27,28,30,31,33,34,36,40,43] %4:50
        
    % extract a frame
    rgb = box{frameNum}.Color; % Extracting the colour data
    %rgb_interim = rgb - bg_rgb;
    point = box{frameNum}.Location; % Extracting the xyz data
    pc = pointCloud(point, 'Color', rgb); % Creating a point-cloud variable
    pc_clean = removeInvalidPoints(pc);
    
    %Show the initial pointcloud
    figure(1)
    showPointCloud(pc)
    pause(2)
    
    color_pc=pc.Color;
    r=color_pc(:,1);
    g=color_pc(:,2);
    b=color_pc(:,3);
    
    Z_value = pc.Location(:,3); 
    
    %All points far from object can be set to colour value 0.
    %<Enter formula used for finding linear index here>
    for i=1:50920
        r(i)= 0;
        g(i)= 0;
        b(i)= 0;
    end
    
    %Threshold the rgb values based on the pointcloud depth (thresh=0.65)
    %Threshold value identified from visual inspection of the point cloud
    %data.
    for i=1:217088
        if (Z_value(i) >= 0.65) && (Z_value(i) < 0.86)
            r(i)= r(i); g(i)= g(i); b(i)= b(i);
        else
            r(i)= 0; g(i)= 0; b(i)= 0;
        end
        
    %Use colour thresholding to remove the hands(and wooden frame
    %background)
        if ((r(i) > 71) && (r(i) < 134)) && ((g(i) > 40) && (g(i) < 119))...
            && ((b(i) > 30) && (b(i) < 96))
            
            r(i)= 0; g(i)= 0; b(i)= 0;
        end               
    end
   
    
    %Use morphology to enhance the image of the box
    %We dilate to fill some holes, then erode again.
    SE1 = strel('arbitrary',15);
    SE2 = strel('square',2);
    r_interim = imdilate(r,SE1);
    g_interim = imdilate(g,SE1);
    b_interim = imdilate(b,SE1);
    r_final = imerode(r_interim,SE2);
    g_final = imerode(g_interim,SE2);
    b_final = imerode(b_interim,SE2);
    
    pc_foreground(:,1)=r_final;
    pc_foreground(:,2)=g_final;
    pc_foreground(:,3)=b_final;
    
        
    %Reconstruct colour image from point cloud data.
    rec_r=reshape(r_final,[512,424]);
    rec_g=reshape(g_final,[512,424]);
    rec_b=reshape(b_final,[512,424]);
    new_rgb(:,:,1)=rec_r;
    new_rgb(:,:,2)=rec_g;
    new_rgb(:,:,3)=rec_b;
    color = {'red'}; %used later in adding normals
    foreground=new_rgb;
    
    %Display rgb image of thresholded box(doesn't appear till frame 4)
    figure(2)
    imshow(foreground)
    frameNum
    pause(3) %Pause here to check 2 planes visible and enough structure
end
    
