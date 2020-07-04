function [newSimPlane, freeBeds, newPositive, conductedTests] = MakeTests(simPlane, planeSize, testedProcent, testSensitivity, freeHospitalBeds)

    N0 =  ceil((1 - testedProcent)*planeSize*planeSize);
    tests = ones(planeSize, planeSize);
    tests(1:N0) = 0; 
    tests(randperm(numel(tests))) = tests;
    
    positiveCnt = 0;

    for i = 1 : planeSize
        for j = 1 : planeSize
            if(tests(i, j) == 1)
                if(rand < testSensitivity && simPlane.healthState(i, j) > 0)
                    if(freeHospitalBeds > 0)
                        simPlane.healthState(i, j) = 3;
                        freeHospitalBeds = freeHospitalBeds - 1;
                    end
                    simPlane.isolationState(i, j) = 2;
                    simPlane.isRevealed(i, j) = 1;
                    
                    positiveCnt = positiveCnt + 1;
                end
            end
        end
    end
    
    newSimPlane = simPlane;
    freeBeds = freeHospitalBeds;
    newPositive = positiveCnt;
    conductedTests = planeSize*planeSize*testedProcent;
end