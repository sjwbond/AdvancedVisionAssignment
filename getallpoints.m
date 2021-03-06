% selects all points in pointlist P that fit the plane and are within
% TOL of a point already in the plane (oldlist)
function [newlist,remaining] = getallpoints(plane,oldlist,P,NP,pcl,PLANETOL,DISTTOL)

  pnt = ones(4,1);
  [N,W] = size(P);
  [Nold,W] = size(oldlist);
  %DISTTOL = 0.01;
  %PLANETOL = 1;%10;
  tmpnewlist = zeros(NP,1);
  tmpnewlist(1:Nold) = oldlist;       % initialize fit list
  tmpremaining = zeros(NP,1);           % initialize unfit list
  countnew = Nold;
  countrem = 0;
 
  %for each point in the unallocated set (P)
  %Check the distances
  for i = 1 : N
    pnt(1:3) = pcl(P(i),:);
    planedist(i) = abs(pnt'*plane);
  end
  
  %figure(10); histogram(planedist);
   %prctile(planedist,0.1); %0.01; %median(dist)-min(dist); %max(dist)-min(dist); 
  
    % while you could add a new point to the plane keep trying to add more
    % points
    %fittedpoints = 1;
    %while fittedpoints >0
    %    fittedpoints = 0;
        %for each point in the unallocated set (P)
        

    %end
  
  
  
  for i = 1 : N
    pnt(1:3) = pcl(P(i),:);
    notused = 1;
    
    % see if point lies in the plane
    if planedist(i) < PLANETOL
      % see if an existing nearby point already in the set
      for k = 1 : Nold
        if norm(pcl(oldlist(k),:) - pcl(P(i),:)) < DISTTOL
          countnew = countnew + 1;
          tmpnewlist(countnew) = P(i);
          notused = 0;
          break;
        end
      end      
    end
  
    if notused
      countrem = countrem + 1;
      tmpremaining(countrem) = P(i);
    end
  end

  newlist = transpose(tmpnewlist(1:countnew));
  remaining = transpose(tmpremaining(1:countrem));
    countnew
    countrem
    Nold

end
