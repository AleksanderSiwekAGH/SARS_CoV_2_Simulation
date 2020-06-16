close all;
clear all;
clc;

%% init
planeSize = 100;

numberOfSimulations = 2;
numberOfSimulationSteps = 123;

population = 38000000;
rawData = readtable("Poland_coronaVirusData_utf8.csv");
startInfectiousness = 0.05;

startIsolationStates = [0.76 0.19 0.02 0.005 0.005];
isolationMults = [1 0.5 0.2 0.95 0.9];

chanceToGetSick = 0.75;
avIncubation = 7;
sigma = 5;

avDamage = 2;
sigmaDamage = 3;

demography = []; % TO DO
startHealth = 10;

healthCareLimit = 0.1;
chanceToGoToHospitalByYourself = 0.05; %To Do

startTestedProcent = 0.002;
testIncomPerDay = 0.002;
testSensitivity = 0.95;

protectingMult = 0.00005;
organizingMult = 0.0001;

chanceToGetSickAgainMul = 0.75;

dispSize = 10; % outdated right now

%% prepareData
normalizedData = NormalizeData(rawData, planeSize*planeSize, population);
isoStates = floor(startIsolationStates * planeSize * planeSize);

lethality = rawData.deaths(end)/(rawData.deaths(end) + rawData.confirmed(end))/5;
recoveryChance = rawData.recovered(end)/(rawData.confirmed(end));
startTestedProcent = floor(normalizedData.tests(end))/(planeSize*planeSize);

confirmed(1) = [normalizedData.confirmed(end)];
deaths(1) = [normalizedData.deaths(end)];
recovered(1) = [normalizedData.recovered(end)];
testedPositive(1) = [0];
tests(1) = [0];
hospitalFreeBeeds(1) = [0];
iterations(1) = [1];

%% simulationLoop
for simulation = 1 : numberOfSimulations
normalizedData = NormalizeData(rawData, planeSize*planeSize, population);
isoStates = floor(startIsolationStates * planeSize * planeSize);
lethality = rawData.deaths(end)/(rawData.deaths(end) + rawData.confirmed(end))/5;
recoveryChance = rawData.recovered(end)/(rawData.confirmed(end));
simPlane = CreateSimulationPlane(planeSize, normalizedData.confirmed(end), normalizedData.deaths(end), isoStates, startHealth);
testedProcent = startTestedProcent;
freeHospitalBeds = healthCareLimit*planeSize*planeSize;
peopleAwarness = (rawData.movementRestriction(end) + rawData.informationPolitics(end)) / 20;
    for iteration = 1 : numberOfSimulationSteps
        [protect  trash] = size(find(simPlane.isolationState == 3));
        [organizing trash] = size(find(simPlane.isolationState == 4));
        
        infectiousness = startInfectiousness - (protect * protectingMult + organizing *organizingMult)
        if(mod(iteration, 8) == 1)
            DisplaySimGrid(simPlane, planeSize, iteration, dispSize);
        end
        
        newDeaths = 0;
        newRecoveries = 0;
        newCases = 0;
        
        for i = 1 : planeSize
           for j = 1 : planeSize
               [simPlane, freeHospitalBeds, isDead, newIll, isRecovered] = CheckState(simPlane, ... 
                                    i, ...
                                    j, ...
                                    avIncubation, ...
                                    sigma, ...
                                    planeSize,...
                                    lethality, ...
                                    infectiousness, ...
                                    avDamage, ...
                                    sigmaDamage, ...
                                    isolationMults,...
                                    recoveryChance, ...
                                    freeHospitalBeds, ...
                                    peopleAwarness, ...
                                    chanceToGetSick, ...
                                    chanceToGetSickAgainMul);
                                
               newDeaths = newDeaths + isDead;
               newCases = newCases + newIll;
               newRecoveries = newRecoveries + isRecovered;
               
           end
        end     
        
        [simPlane, freeHospitalBeds, newPositive, conductedTests] = MakeTests(simPlane, planeSize, testedProcent, testSensitivity, freeHospitalBeds);
        if(testedProcent ~= 1)
            testedProcent = testedProcent * (1 + testIncomPerDay) + normrnd(0.001, 0.001);
        end
        
        if(simulation == 1 && iteration ~= 1)
            iterations = [iterations(1, :), iteration];
        end
        
        hospitalFreeBeeds(simulation, iteration) = freeHospitalBeds;
        if(iteration ~= 1)
            deaths(simulation, iteration) = newDeaths + deaths(simulation, iteration - 1);
            confirmed(simulation, iteration) = newCases + confirmed(simulation, iteration - 1);
            recovered(simulation, iteration) = newRecoveries + recovered(simulation,iteration - 1);
        else
            deaths(simulation, iteration) = newDeaths;
            confirmed(simulation, iteration) = newCases;
            recovered(simulation, iteration) = newRecoveries;  
            
        end
        
        tests(simulation, iteration) = conductedTests;
        testedPositive(simulation, iteration) = newPositive;      
    end
end

%% ploting statistics
figure()
DisplaySimGrid(simPlane, planeSize, iteration, dispSize);

figure()
subplot(2, 3, 1)
plot(iterations, confirmed)
title("Cases")

subplot(2, 3, 2)
plot(iterations, deaths)
title("Deaths")

subplot(2, 3, 3)
plot(iterations, recovered)
title("Recovered")

subplot(2, 3, 4)
plot(iterations, tests)
title("Tests")

subplot(2, 3, 5)
plot(iterations, testedPositive)
title("TestedPositive")

subplot(2, 3, 6)
plot(iterations, hospitalFreeBeeds)
title("Hospital free beds")



