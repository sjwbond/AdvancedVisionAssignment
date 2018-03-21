function output = get_planes(pc, objectIDs)

    pcl = filteronid(pc.Location,objectIDs);
    
    output = uint32(zeros(size(pc.Location,1),1));
    
    %[pcl, IDs] = remove_nans(pcl);
    
    [NPts,W] = size(pcl);
    patchid = zeros(NPts,1);
    planelist = zeros(20,4);

    remaining = objectIDs;
    
    for i = 1 : 3

      % select a random small surface patch
      [oldlist,plane] = select_patch(pc.Location, remaining);
        
      emptyarray = isempty(oldlist);
      
      if emptyarray == 0
          % grow patch
          stillgrowing = 1;
          while stillgrowing

            % find neighbouring points that lie in plane
            stillgrowing = 0;
            [newlist,remaining] = getallpoints(plane,oldlist,remaining,NPts,pc.Location);
            [NewL,W] = size(newlist);
            [OldL,W] = size(oldlist);


            if i == 1
             plot3(pc.Location(newlist(:),1),pc.Location(newlist(:),2),pc.Location(newlist(:),3),'r.')
             save1=newlist;
            elseif i==2 
             plot3(pc.Location(newlist(:),1),pc.Location(newlist(:),2),pc.Location(newlist(:),3),'b.')
             save2=newlist;
            elseif i == 3
             plot3(pc.Location(newlist(:),1),pc.Location(newlist(:),2),pc.Location(newlist(:),3),'g.')
             save3=newlist;
            end

            pause(1)

            if NewL > OldL + 50
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
    pause(1)

    ['**************** Segmentation Completed']

    end

end
