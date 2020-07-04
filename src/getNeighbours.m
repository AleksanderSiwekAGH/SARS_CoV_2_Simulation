function [neighbours] = getNeighbours(item)
    x = item(1);
    y = item(2);
    
    neighbours(:,:,1) = [[x-1, y]
                       [x+1, y]
                       [x, y-1]
                       [x, y+1]];
                  
    neighbours(:,:,2) = [[x-1, y-1]
                       [x-1, y+1]
                       [x+1, y-1]
                       [x+1, y+1]];
                   
    neighbours(:,:,3) = [[x-2, y]
                       [x+2, y]
                       [x, y-2]
                       [x, y+2]];
end

