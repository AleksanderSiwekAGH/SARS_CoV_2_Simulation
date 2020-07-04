function normalizedData = NormalizeData(data, mul, population)
    [x, y] = size(data);
    for i = 2 : y
        for j = 1 : x
            if(data.(i)(j) < 0)
                data.(i)(j) = 0;
            else
                data.(i)(j) = round(data.(i)(j) * mul / population);
            end
        end  
    end
    normalizedData = data;
end