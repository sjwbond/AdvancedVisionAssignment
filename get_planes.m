function [output, planecount] = get_planes(pc, objectIDs)

    pcl = pc.Location;
    pclfiltered = filteronid(pc.Location,objectIDs);
    
    output = uint32(zeros(size(pc.Location,1),1));
    
    %[pcl, IDs] = remove_nans(pcl);
    
    [NPts,W] = size(pcl);
    patchid = zeros(NPts,1);
    planelist = zeros(20,4);

    remaining = objectIDs;
    
    cla reset;
    planecount = 0;
    for i = 1 : 3

      % select a random small surface patch
      [oldlist,plane] = select_patch_matrix(pcl, remaining, 200, 0.01,0.00001,pc,4);
        
         if i == 1
            plot3(pc.Location(oldlist(:),1),pc.Location(oldlist(:),2),pc.Location(oldlist(:),3),'r.'); hold on;
         elseif i==2 
            plot3(pc.Location(oldlist(:),1),pc.Location(oldlist(:),2),pc.Location(oldlist(:),3),'b.'); hold on;
         elseif i == 3
            plot3(pc.Location(oldlist(:),1),pc.Location(oldlist(:),2),pc.Location(oldlist(:),3),'g.'); hold on;
         end

      emptyarray = isempty(oldlist);  
      
      if emptyarray == 0
          planecount = planecount + 1
          % grow patch
          stillgrowing = 1;          
          while stillgrowing

            % find neighbouring points that lie in plane
            stillgrowing = 0;
            [newlist,remaining] = getallpoints(plane,oldlist,remaining,NPts,pc.Location,0.001,0.2);
            newlist = transpose(newlist);
            remaining = transpose(remaining);
            [NewL,W] = size(newlist);
            [OldL,W] = size(oldlist);


            if i == 1
             plot3(pc.Location(newlist(:),1),pc.Location(newlist(:),2),pc.Location(newlist(:),3),'r.'); hold on;
             %save1=newlist;
            elseif i==2 
             plot3(pc.Location(newlist(:),1),pc.Location(newlist(:),2),pc.Location(newlist(:),3),'b.'); hold on;
             %save2=newlist;
            elseif i == 3
             plot3(pc.Location(newlist(:),1),pc.Location(newlist(:),2),pc.Location(newlist(:),3),'g.'); hold on;
             %save3=newlist;
            end

            pause(0.001)

            if NewL > OldL + 10
                % refit plane
                [newplane,fit] = fitplane(newlist,pc.Location);
                [newplane',fit,NewL]
                planelist(i,:) = newplane';
                if fit > 0.04*NewL       % bad fit - stop growing
                    break
                end
                  stillgrowing = 1;
                  oldlist = newlist;
                  plane = newplane;
            end
        end
      end
      
    if emptyarray == 0
        for idx = 1:NewL
            output(newlist(idx),1) = i;
        end
    end
    
    waiting=1
    pause(0.1)

    ['**************** Segmentation Completed']

    end

end
