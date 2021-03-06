% find a candidate planar patch
% if not enough remaining points, returns empty fitlist
% if cannot find a good patch, returns empty fitlist
function [fitlist,plane] = select_patch(points, IDs, fittol, DISTTOL, restol)

  [L,D] = size(IDs);
  bestres = 1;
  nofits = 0;
  maxfits = 0;
  %tmpnew = zeros(L,3);
  %tmprest = zeros(L,3);
    tmpnew = uint32(zeros(L,1));
    tmprest = uint32(zeros(L,1));
    
  % if not enough remaining points, return empty list
  if L < 40
    fitlist=[];
    plane=[];
    return
  end

  % try different random points until a successful plane is found
  % pointlist = randperm(L); % not relevant here as we know that the PCL is
  % ordered
  
  
  %dont try random points, arrange the matrix by wieghted distance or put the bottom half at the top!
  %pointlist(size(L)/2
    dists = getdistancetoallotherpoints(points,IDs);
    [~,distsort]=sort(dists); %Get the order of dists
    pointlistids=[1:1:L];%(distsort);
    pointlist = pointlistids(distsort);
    
    %[M,I] = min(dists);
  
  success = 0;
  
  for n = 1 : L

    % find points in the neighborhood of the given point
    %DISTTOL = 5.0;
    fitcount = 0;
    restcount = 0;
  
    idx = IDs(pointlist(n));
    pnt = points(idx,:);
      
    for i = 1:L
        dist(i) = norm(points(IDs(pointlist(i)),:) - pnt);
    end
    
    %histogram(dist);
    
    %DISTTOL = 0.01; %prctile(dist,0.5);
    
    for i = 1 : L
      if dist(i) < DISTTOL
        fitcount = fitcount + 1;
        tmpnew(fitcount) = IDs(pointlist(i));%tmpnew(fitcount,:) = points(i,:);
      else
        restcount = restcount + 1;
        tmprest(restcount) = IDs(pointlist(i));%tmprest(restcount,:) = points(i,:);
      end
    end
    
    oldlist = tmprest(1:restcount); %oldlist = tmprest(1:restcount,:);
    
    if fitcount > fittol
        
        nofits = nofits+1;
      % fit a plane
      [plane,resid] = fitplane(tmpnew(1:fitcount),points);
      fitcount
      resid
      
      if fitcount > maxfits
         maxfits = fitcount; 
      end
      
      if resid < bestres
        bestres = resid;
        bestplane = plane;
        fitlist = tmpnew(1:fitcount,:);
      end
      %if resid < restol %check this number if points are far away from plane
      %  fitlist = tmpnew(1:fitcount,:);
      %  return
      %end
    end
  end
  
  maxfits
  %fitlist=[];  % failed to find a plane
  plane=bestplane;
 
