function [newSimPlane,  newCases] = Infect(simPlane, x, y, avDays, sigma, infectiousness, planeSize, chanceToGetSickAgainMul)
    newCases = 0;
    if(x - 1 > 0 && y - 1 > 0 && simPlane.healthState(x - 1, y - 1) == 0)
        if(simPlane.wasRecovered(x - 1, y - 1) == 0)
            mul = 1;
        else
            mul = simPlane.wasRecovered(x - 1, y - 1) * chanceToGetSickAgainMul;
        end
        if(rand < infectiousness * simPlane.infectionMul(x - 1, y - 1)*mul)
            simPlane.healthState(x - 1, y - 1) = 1;
            simPlane.daysToFirstSymptoms(x - 1, y - 1) = round(abs(normrnd(avDays, sigma)));
            newCases = newCases + 1;
        end
    end
    
    if(x - 1 > 0 && y > 0 && simPlane.healthState(x - 1, y) == 0)
        if(simPlane.wasRecovered(x - 1, y) == 0)
            mul = 1;
        else
            mul = simPlane.wasRecovered(x - 1, y) * chanceToGetSickAgainMul;
        end
        if(rand < infectiousness * simPlane.infectionMul(x - 1, y)*mul)
            simPlane.healthState(x - 1, y) = 1;
            simPlane.daysToFirstSymptoms(x - 1, y) = round(abs(normrnd(avDays, sigma)));
            newCases = newCases + 1;
        end
    end
    
    if(x - 1 > 0 && y + 1 < planeSize && simPlane.healthState(x - 1, y + 1) == 0)
        if(simPlane.wasRecovered(x - 1, y + 1) == 0)
            mul = 1;
        else
            mul = simPlane.wasRecovered(x - 1, y + 1) * chanceToGetSickAgainMul;
        end
        if(rand < infectiousness * simPlane.infectionMul(x - 1, y + 1)*mul)
            simPlane.healthState(x - 1, y + 1) = 1;
            simPlane.daysToFirstSymptoms(x - 1, y + 1) = round(abs(normrnd(avDays, sigma)));
            newCases = newCases + 1;
        end
    end
    
    if(y - 1 > 0 && simPlane.healthState(x, y - 1) == 0)
        if(simPlane.wasRecovered(x, y - 1) == 0)
            mul = 1;
        else
            mul = simPlane.wasRecovered(x, y - 1) * chanceToGetSickAgainMul;
        end
        if(rand < infectiousness * simPlane.infectionMul(x, y - 1)*mul)
            simPlane.healthState(x, y - 1) = 1;
            simPlane.daysToFirstSymptoms(x, y - 1) = round(abs(normrnd(avDays, sigma)));
        end
    end
    
    if(y + 1 < planeSize && simPlane.healthState(x, y + 1) == 0)
        if(simPlane.wasRecovered(x, y + 1) == 0)
            mul =1;
        else
            mul = simPlane.wasRecovered(x, y + 1) * chanceToGetSickAgainMul;
        end
        if(rand < infectiousness * simPlane.infectionMul(x, y + 1)*mul)
            simPlane.healthState(x, y + 1) = 1;
            simPlane.daysToFirstSymptoms(x, y + 1) = round(abs(normrnd(avDays, sigma)));
            newCases = newCases + 1;
        end
    end
    
    if(x + 1 < planeSize && y - 1 > 0 && simPlane.healthState(x + 1, y - 1) == 0)
        if(simPlane.wasRecovered(x + 1, y - 1) == 0)
            mul =1;
        else
            mul = simPlane.wasRecovered(x + 1, y - 1) * chanceToGetSickAgainMul;
        end
        if(rand < infectiousness * simPlane.infectionMul(x + 1, y - 1)*mul)
            simPlane.healthState(x + 1, y - 1) = 1;
            simPlane.daysToFirstSymptoms(x + 1, y - 1) = round(abs(normrnd(avDays, sigma)));
            newCases = newCases + 1;
        end
    end
    
    if(x + 1 < planeSize && y > 0 && simPlane.healthState(x + 1, y) == 0)
        if(simPlane.wasRecovered(x + 1, y) == 0)
            mul =1;
        else
            mul = simPlane.wasRecovered(x + 1, y) * chanceToGetSickAgainMul;
        end
        if(rand < infectiousness * simPlane.infectionMul(x + 1, y)*mul)
            simPlane.healthState(x + 1, y) = 1;
            simPlane.daysToFirstSymptoms(x + 1, y) = round(abs(normrnd(avDays, sigma)));
            newCases = newCases + 1;
        end
    end
    
    if(x + 1 < planeSize && y + 1 < planeSize && simPlane.healthState(x + 1, y + 1) == 0)
        if(simPlane.wasRecovered(x + 1, y + 1) == 0)
            mul =1;
        else
            mul = simPlane.wasRecovered(x + 1, y + 1) * chanceToGetSickAgainMul;
        end
        if(rand < infectiousness * simPlane.infectionMul(x + 1, y + 1)*mul)
            simPlane.healthState(x + 1, y + 1) = 1;
            simPlane.daysToFirstSymptoms(x + 1, y + 1) = round(abs(normrnd(avDays, sigma)));
            newCases = newCases + 1;
        end
    end
    
    newSimPlane = simPlane;
end