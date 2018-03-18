%% For each frame extract the box from the depth data.
box = load('assignment_1_box.mat');
box = box.pcl_train;
plane_project1 = [];

%Form point cloud variable and extract colour and location info incase
%decide to use this first cell image for background subtraction.
bg_rgb=box{1}.Color;
point_background = box{1}.Location; % Extracting the xyz data
pc_background = pointCloud(point_background, 'Color', bg_rgb); % Creating a point-cloud variable