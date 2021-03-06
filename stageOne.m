function output = stageOne(myFile,frames)
    

    %% Load the training data 
    if exist(myFile, 'file') == 2

        box = load(myFile);
        box = box.pcl_train;

        %% Uncomment to load the test file
        %box = load('assignment_1_test.mat');
        %box = box.pcl_test;

        background = box{1}.Color;
        bg = background;
        %figure(1)
        %imag2d(box{1}.Color)
        %figure(2)
        %imag2d(box{2}.Color)

        rec_r = reshape(bg(:,1), [512, 424]);
        rec_g = reshape(bg(:,2), [512, 424]);
        rec_b = reshape(bg(:,3), [512, 424]);
        bg = cat(3, rec_r', rec_g', rec_b');

        objectLocation = [-0.71,-0.30,0.81];
        frameCount = size(frames,2)
        % display the points as a point cloud and as an image
        for index = 1:frameCount %length(box) % Reading the 50 point-clouds

                frameNum = frames(index);

                % extract a frame

                rgb = box{frameNum}.Color; % Extracting the colour data
                [x,y,z] = size(rgb) ;

                point = box{frameNum}.Location; % Extracting the xyz data

                pc = pointCloud(point, 'Color', rgb); % Creating a point-cloud variable
                pc_object = uint8(zeros(size(pc.Location,1),1));
                for i = 1:size(pc.Color)
                   if isnan(pc.Location(i,1))
                       pc_object(i) = 0;
                   else
                       pc_object(i) = 1;
                   end
                end

                % display the point cloud and corresponding image
                %figure(2);
                %imag2d(rgb) % Shows the 2D images
                %figure(3);
                %imag2d(pc.Color)

                %figure(100+frameNum)


                %threshold on distance first round
                for i = 8:8
                    sigma = (11-i)/20;
                    tmp = pc_distance(pc.Location,pc.Color,objectLocation,sigma, pc_object);
                end

                pc_object = tmp;

                locationThresh1 = single(zeros(size(pc.Location,1),1));

                %HSV Thresholding
                pc_object = threshold_HSV(pc, pc_object);

                pc_object = denoise_pc(pc,pc_object,1);

                rgb = RGB_with_Object(pc,pc_object);
                figure(4); imshow(rgb);

                steps = 2;
                max = 12;
                min = 6;
                for i = 1:steps
                    sigma = ((max-min)/steps)*i+min
                    tmp = pc_distance(pc.Location,pc.Color,objectLocation,sigma, pc_object);
                end

                pc_object = tmp;

                for i = 1:3
                    pc_object = density_thresholding(pc,pc_object,8,3);
                    points = pcObject(pc,pc_object);        
                    [pc_new, objectpointIDs] = remove_points_IDs(pc,pc_object);
                    showPointCloud(pc_new)
                end

                %Get All Planes

               [planes, planecount] = get_planes(pc,objectpointIDs);
               pcplanes(index,:,1) = planes(:,1);
               frameNum

        end
        
        savepath = 'C:\Users\sjwbo\Documents\MATLAB\AV\Code\Stage one\'
        
        %write the vectors to file
        for index = 1:frameCount %length(box) % Reading the 50 point-clouds
            frameNum = frames(index);
            filepath = strcat(savepath, num2str(frameNum,'%02d'), " PixelToPlane.csv");
            csvwrite(filepath, transpose(pcplanes(index,:,1)));
        end


        output = 1;

    end
end