%% Invoke on infected or infected_and_sick context

allNeighbours = getNeighbours([x, y]);
[nX, nY, nZ] = size(allNeighbours);
baseProbability = realProbabilityOfInfection;

for i = 1:nZ
    neighbours = allNeighbours(:,:,i);
    realProbabilityOfInfection = baseProbability/i;
    for ni = 1:length(neighbours)
        nx = neighbours(ni, 1);
        ny = neighbours(ni, 2);
        if (itemExists([nx, ny], X, Y))
            if (Q2(nx, ny) == recovered)
                realProbabilityOfInfection = realProbabilityOfInfection/6;
            end
            if (rand()*100 > 100 - realProbabilityOfInfection)
                if (isOneStateTransitionValid(Q2_trans, Q2(nx, ny), infected))
                    [Q2, itersInQ2] = makeTransition([nx, ny], infected, Q2, itersInQ2, iter);
                    todaysInfected = todaysInfected + 1;
                end
            end
        end
    end
end

