% find a candidate planar patch
% if not enough remaining points, returns empty fitlist
% if cannot find a good patch, returns empty fitlist
function [fitlist,plane] = select_patch_matrix(points, IDs, fittol, DISTTOL, restol,pc, pixelrange)

  [L,D] = size(IDs);
  %tmpnew = zeros(L,3);
  %tmprest = zeros(L,3);
    tmpnew = uint32(zeros(L,1));
    tmprest = uint32(zeros(L,1));
    bestres = 1;
  % if not enough remaining points, return empty list
  if L < 40
    fitlist=[];
    plane=[];
    return
  end

    %[M,I] = min(dists);
  
    success = 0;
    %for each pixel
    
    reqfit = (pixelrange * 2 + 1)^2;
    
    for n = 1 : L
        
        % get the pixel Location
        [plx,ply] = getPixelFromIndex(IDs(n));
        
        fitcount = 0;
        for i = -pixelrange:pixelrange
           x = plx + i;
           for j = -pixelrange:pixelrange 
               y = ply + j;
               
               id = getIndexFromPixel(x,y);
           
               if isnan(points(id,1)) ==0
                  fitcount = fitcount +1;
                  tmpnew(fitcount) = id;
               end
               
           end
           
        end
        
        if fitcount == reqfit
            %every pixel is a match fit a plane on these pixels
            [plane,resid] = fitplane(tmpnew(1:fitcount),points);
            
            if resid < bestres
               bestres = resid
               bestplane = plane
               fitlist = tmpnew(1:fitcount);
            end
        end
                 
    end
    
    plane = bestplane;
   
end