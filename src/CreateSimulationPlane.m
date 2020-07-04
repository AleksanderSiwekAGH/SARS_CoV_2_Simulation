function simulationPlane = CreateSimulationPlane(planeSize, confirmed, dead, startIsolationStates, startHealth)
    x = randperm(planeSize, dead + confirmed);
    y = randperm(planeSize, dead + confirmed);
    
    for i = 1 : planeSize
        for j = 1 : planeSize 
            healthState(i, j) = 0;
            isolatingState(i, j) = 0;
            isRevealed(i, j) = 0;
            wasRecovered(i, j) = 0;
            daysToFirstSymptoms(i, j) = 0;
            health(i, j) = startHealth;
            infectionMul(i ,j) = 1;
            isDead(i, j) = 0;
        end
    end
    
    i = 1;
    for j = 1 : dead
        healthState(x(i), y(i)) = 4;
        i = i+1;
        isDead(i, j) = 1;
    end
    
    for j = 1 : confirmed
        healthState(x(i), y(i)) = 2;
        i = i+1;
    end
        
    isoStates = horzcat(0*ones(1, startIsolationStates(1)), ...
        1*ones(1, startIsolationStates(2)), ...
        2*ones(1, startIsolationStates(3)), ...
        3*ones(1, startIsolationStates(4)),...
        4*ones(1, startIsolationStates(5)));
    
    [trash, isoSize] = size(isoStates);
    if(size(isoStates) < planeSize*planeSize)
        isoStates = horzcat(isoStates, zeros(1, planeSize*planeSize - isoSize));
    end
    isoStates = isoStates(randperm(length(isoStates)));
        
    cnt = 1;
    for i = 1 : planeSize
        for j = 1 : planeSize
            isolationState(i, j) = isoStates(cnt);
            cnt = cnt + 1;
        end
    end

    
    simulationPlane = table(healthState, isolationState, isRevealed, wasRecovered, daysToFirstSymptoms, health, infectionMul, isDead);
end