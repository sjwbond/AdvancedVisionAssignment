function [x,y] = getPixelFromIndex(index)
    
    x = floor(index / 512);
    y = rem(index, 512);

end