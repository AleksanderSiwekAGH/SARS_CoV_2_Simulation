function [newSimPlane, newFreeBeds, isDead, newIll, isRecovered] = CheckState(simPlane, x, y, avDaysToSymptoms,...
    sigma, planeSize, lethality, infectiousness, avDamge, sigmaDamge, ...
    isolationMult, recoveryChance, freeBeds, peopleAwarness, chanceToGetSick, chanceToGetSickAgainMul)
    
    isDead = 0;
    newIll = 0;
    isRecovered = 0;

    if(simPlane.isDead(x, y) ~= 1)
        switch simPlane.isolationState(x, y)
            case 0
                if(rand < peopleAwarness)
                    simPlane.islolationState(x, y) = 1;
                end
                simPlane.infectionMul(x, y) = isolationMult(1);
                
            case 1
                simPlane.infectionMul(x, y) = isolationMult(2);
                if(rand < 0.00001)
                    simPlane.islolationState(x, y) = 3;
                end
            case 2
                simPlane.infectionMul(x, y) = isolationMult(3); 
            case 3
                simPlane.infectionMul(x, y) = isolationMult(4);
                if(rand < 0.000005)
                    simPlane.islolationState(x, y) = 4;
                end
            case 4
                simPlane.infectionMul(x, y) = isolationMult(5); 
                
            case 5 % dead
        end


        switch simPlane.healthState(x, y)
            case 0 % healthy

            case 1 % no symptoms
                [simPlane, newIll] = Infect(simPlane, x, y, avDaysToSymptoms, sigma, infectiousness, planeSize, chanceToGetSickAgainMul); 

                simPlane.daysToFirstSymptoms(x, y) = simPlane.daysToFirstSymptoms(x, y) - 1;
                if(simPlane.daysToFirstSymptoms(x, y) == 0)
                    if(rand < chanceToGetSick)
                        simPlane.healthState(x, y) = 2;
                    else
                       simPlane.healthState(x, y) = 0;
                    end
                end

            case 2 % sick        
                [simPlane, newIll] = Infect(simPlane, x, y, avDaysToSymptoms, sigma, infectiousness, planeSize, chanceToGetSickAgainMul);           

                if(simPlane.health(x, y) <= 0)
                    if(rand < lethality) %zabijanie pacjenta
                        simPlane.isDead(x, y) = 1;
                        simPlane.healthState(x, y) = 4;
                        simPlane.isolationState(x, y) = 5;
                        isDead = 1;
                    end
                end
                
                if(rand < recoveryChance/5)
                        simPlane.healthState(x, y) = 0;
                        simPlane.health(x, y) = 14;
                        simPlane.isolationState(x, y) = 1;
                        simPlane.wasRecovered(x, y) = simPlane.wasRecovered(x, y) +  1;
                        simPlane.isRevealed(x, y) = 0;
                        freeBeds = freeBeds + 1;
                        isRecovered = 1;
                end

                simPlane.health(x, y) = simPlane.health(x, y) - abs(normrnd(avDamge, sigmaDamge));

            case 3 % hospital
                [simPlane, newIll] = Infect(simPlane, x, y, avDaysToSymptoms, sigma, infectiousness, planeSize, chanceToGetSickAgainMul); 

                if(simPlane.health(x, y) <= 0)
                    if(rand < lethality) %zabijanie pacjenta
                        simPlane.isDead(x, y) = 1;
                        simPlane.healthState(x, y) = 4;
                        simPlane.isolationState(x, y) = 3;
                        freeBeds = freeBeds + 1;
                        isDead = 1;
                    end

                    if(rand < recoveryChance)
                        simPlane.healthState(x, y) = 0;
                        simPlane.health(x, y) = 14;
                        simPlane.isolationState(x, y) = 1;
                        simPlane.wasRecovered(x, y) = simPlane.wasRecovered(x, y) + 1;
                        simPlane.isRevealed(x, y) = 0;
                        freeBeds = freeBeds + 1;
                        isRecovered = 1;
                    end

                else
                    simPlane.health(x, y) = simPlane.health(x, y) - abs(normrnd(avDamge*0.5, sigmaDamge*0.5));                
                end

            case 4 % dead

        end
    end
    
    newSimPlane = simPlane;
    newFreeBeds = freeBeds;
end