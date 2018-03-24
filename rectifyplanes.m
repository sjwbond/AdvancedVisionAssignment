function [planepoints,planes] = rectifyplanes(pc, inplanepoints)

    pcl = pc.Location;
    planepoints = uint32(zeros(size(pc.Location,1),1));
    planes = zeros(3,4);
    %for each plane
    cla reset;
    
    for iPlane = 1:3
        %first get the plane pixels id in a new list
        numFitted = 0;
        numNotFitted = 0;
        fitted = []
        notFitted = []
        
        
        for iPixel = 1: size(pc.Location,1)
            if isnan(pcl(iPixel,1)) == 0
                if inplanepoints(iPixel,1) == iPlane

                    numFitted = numFitted +1;
                    fitted(numFitted,1) = iPixel;
                
                else
                    
                    numNotFitted = numNotFitted +1;
                    notFitted(numNotFitted,1) = iPixel;
                    
                end
            end
        end
        
        if iPlane == 1
            plot3(pc.Location(fitted(:),1),pc.Location(fitted(:),2),pc.Location(fitted(:),3),'r.');hold on;
        elseif iPlane==2 
            plot3(pc.Location(fitted(:),1),pc.Location(fitted(:),2),pc.Location(fitted(:),3),'b.');hold on;
        elseif iPlane == 3
            plot3(pc.Location(fitted(:),1),pc.Location(fitted(:),2),pc.Location(fitted(:),3),'g.')
        end
        
        if numFitted > 10
            %now you have the pixels fit the plane
            [plane,fit] = fitplane(fitted,pc.Location);

            %now you have the plane try to grow the points from the full list
            stillgrowing = 1;
            while stillgrowing

                % find neighbouring points that lie in plane
                stillgrowing = 0;

                oldCount = size(fitted,1);
                [fitted,notFitted] = getallpoints(plane,fitted,notFitted,numNotFitted,pc.Location);
                fitted = transpose(fitted);

                if iPlane == 1
                    plot3(pc.Location(fitted(:),1),pc.Location(fitted(:),2),pc.Location(fitted(:),3),'r.');hold on;
                elseif iPlane==2 
                    plot3(pc.Location(fitted(:),1),pc.Location(fitted(:),2),pc.Location(fitted(:),3),'b.');hold on;
                elseif iPlane == 3
                    plot3(pc.Location(fitted(:),1),pc.Location(fitted(:),2),pc.Location(fitted(:),3),'g.')
                end

                if size(fitted,1) > oldCount + 20
                      stillgrowing = 1;
                end

            end

            for idx = 1:size(fitted)
                planepoints(fitted(idx),1) = iPixel;
                planes(iPlane,:) = plane;
            end
        end        
    end
end