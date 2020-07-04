function [doesItExist] = itemExists(item, X, Y)
    x = item(1);
    y = item(2);
    if (x >= 1 && x <= X && y >= 1 && y <= Y)
        doesItExist = 1;
    else
        doesItExist = 0;
    end
end

