function [confirmedNeighbours] = countConfirmedNeighbours(confirmed, item, X, Y)
    confirmedNeighbours = 0;
    allNeighbours = getNeighbours(item);
    for i = 1:2
        neighbours = allNeighbours(:,:,1);
        for ni = 1:length(neighbours)
            nx = neighbours(ni, 1);
            ny = neighbours(ni, 2);
            if (itemExists([nx, ny], X, Y) && confirmed(nx, ny))
                confirmedNeighbours = confirmedNeighbours + 1/i;
            end
        end
    end
end

