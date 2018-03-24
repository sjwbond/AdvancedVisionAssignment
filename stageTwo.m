function output = stageTwo(myFile,frames)

    box = load(myFile);
    box = box.pcl_train;
    
    frameCount = size(frames,2)
    
    for index = 1:frameCount 
        %read the indexes from the file
        frameNum = frames(index);
        
        savepath = 'C:\Users\sjwbo\Documents\MATLAB\AV\Code\Stage one\'
        filepath = strcat(savepath, num2str(frameNum,'%02d'), " PixelToPlane.csv");
        inPlanes = csvread(filepath);
        
        %construct a pointcloud
        rgb = box{frameNum}.Color; % 
        [x,y,z] = size(rgb) ;
        point = box{frameNum}.Location; 
        pc = pointCloud(point, 'Color', rgb);
        
        [planepoints, planes] = rectifyplanes(pc,inPlanes);
        pcplanepoints(index,:,1) = planepoints(:,1);
        pcplanes(index,:,:) = planes(:,:);
    end

end