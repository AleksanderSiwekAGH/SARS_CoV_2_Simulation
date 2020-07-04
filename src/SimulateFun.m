function [] = SimulateFun(app)
%% Load predefined data (states, transitions etc.)
Init;
maxIter = app.FranceDays.Value * itersPerDay;
X = app.FranceSize.Value;
Y = X;
testingRate = app.FranceTestRate.Value;
testingSickRate = testingRate;
howMuchPatientsZero = app.FranceNumberOfPatientsZero.Value;
probabilityOfInfection = app.FranceProbabilityOfInfection.Value;
avgFatalityRate = app.FranceFatalityRate.Value;
seriousCases = app.FranceSeriousCases.Value;

%% Generate initial state
% Each field has it's value, left digit = Q1, right digit = Q2
% Initial state for each field is [no_security_measures, healthy]
initialQ1 = no_security_measures;
initialQ2 = healthy;

Q1 = ones(X, Y) .* initialQ1;
Q2 = ones(X, Y) .* initialQ2;
itersInQ1 = zeros(X, Y);
itersInQ2 = zeros(X, Y);
confirmed = zeros(X, Y);

clear initialQ1 initialQ2;

%% Set random 'patient zero' (or multiple)

for i = 1:howMuchPatientsZero
    patientZeroX = mod(floor(rand()*X), X)+1;
    patientZeroY = mod(floor(rand()*Y), Y)+1;

    Q2(patientZeroX, patientZeroY) = infected;

    clear patientZeroX patientZeroY;
end

%% Simulation

% Figures for visualizing Q1 and Q2 states
% f1 = figure('Name','Q1','NumberTitle','off');
f1 = app.AxesFranceQ1;
% f2 = figure('Name','Q2','NumberTitle','off');
f2 = app.AxesFranceQ2;

% Init starting values
% Daily
dailyConfirmedCases = zeros(1, maxIter);
dailyActiveCasesChange = zeros(1, maxIter);
dailyDeaths = zeros(1, maxIter);
dailyRecovered = zeros(1, maxIter);
dailyInHospitalChange = zeros(1, maxIter);
dailyInfected = zeros(1, maxIter);
dailyTests = zeros(1, maxIter);
% Total
totalInfected = zeros(1, maxIter);
activeCases = zeros(1, maxIter);
totalDeaths = zeros(1, maxIter);
totalInHospital = zeros(1, maxIter);
totalConfirmed = zeros(1, maxIter);
totalRecovered = zeros(1, maxIter);
totalTests = zeros(1, maxIter);

% Simulation loop
visualize(f1, Q1, f2, Q2, 0, X, Y);
iters = 1:maxIter;
iter = 1;
while ~app.FranceStop.Value && iter <= maxIter
    % Init daily values
    todaysConfirmedCases = 0;
    todaysDeaths = 0;
    todaysRecovered = 0;
    todaysInHospitalChange = 0;
    todaysInfected = 0;
    todaysTests = 0;
    
    % How many infected we have [%]
    if (iter > 21)
        prev = totalConfirmed(iter - 20);
    else
        prev = 0;
    end
        
    totalConfirmedRel = sum(sum(confirmed)) - prev;
    totalConfirmedRelPercent = 100*totalConfirmedRel/(X*Y);
    
    if (iter == 1)
        activeCasesPercent = 0;
    else
        activeCasesPercent = 100*activeCases(iter-1)/(X*Y);
    end
    riskCoeff = sqrt(totalConfirmedRelPercent*activeCasesPercent);
    
    for x = 1:X
        for y = 1:Y
            % Q1
            randomNumber = rand()*100;
            randomNumber2 = rand()*100;
            daysInState1 = (iter - itersInQ1(x,y))/itersPerDay;
            if (Q1(x, y) == no_security_measures)
                if (randomNumber > 100 - riskCoeff)
                    if (isStateValid(allowed_states, [self_protecting, Q2(x,y)]))
                        [Q1, itersInQ1] = makeTransition([x, y], self_protecting, Q1, itersInQ1, iter);
                    end
                end
            elseif (Q1(x, y) == infecting)
                
            elseif (Q1(x, y) == self_protecting)
                if (randomNumber > 100 - 0.3*riskCoeff)
                    if (isStateValid(allowed_states, [protecting_others, Q2(x,y)]))
                        [Q1, itersInQ1] = makeTransition([x, y], protecting_others, Q1, itersInQ1, iter);
                    end
                else
                    if (randomNumber2 < daysInState1)
                        [Q1, itersInQ1] = makeTransition([x, y], no_security_measures, Q1, itersInQ1, iter);
                    end
                end
            elseif (Q1(x, y) == protecting_others)
                if (randomNumber > 100 - 0.1*riskCoeff)
                    if (isStateValid(allowed_states, [organizing_protection, Q2(x,y)]))
                        [Q1, itersInQ1] = makeTransition([x, y], organizing_protection, Q1, itersInQ1, iter);
                    end
                else
                    if (randomNumber2 < daysInState1)
                        [Q1, itersInQ1] = makeTransition([x, y], self_protecting, Q1, itersInQ1, iter);
                    end
                end
            elseif (Q1(x, y) == organizing_protection)
                if (randomNumber2 < daysInState1)
                        [Q1, itersInQ1] = makeTransition([x, y], protecting_others, Q1, itersInQ1, iter);
                end
            end

            % Q2
            if (Q2(x, y) == healthy)
                
                % Tested if neighbours are confirmed
                if (countConfirmedNeighbours(confirmed, [x, y], X, Y) >= testingNotSickThreshold)
                    if (rand()*100 < testingRate)
                        testItem;
                    end
                end
                
            elseif (Q2(x, y) == in_quarantine)
                
                daysInQuarantine = (iter - itersInQ2(x, y))/itersPerDay;
                if (daysInQuarantine > 14)
                    [Q2, itersInQ2] = makeTransition([x, y], healthy, Q2, itersInQ2, iter);
                else
                    randomNumber = rand()*100;
                    if (randomNumber > 100-probabilityOfInfection)
                        [Q2, itersInQ2] = makeTransition([nx, ny], infected, Q2, itersInQ2, iter);
                        todaysInfected = todaysInfected + 1;
                    end
                end
                
            elseif (Q2(x, y) == infected)
                
                % Can be tested if neighbours are confirmed
                if (countConfirmedNeighbours(confirmed, [x, y], X, Y) >= testingNotSickThreshold)
                    if (rand()*100 < testingRate)
                        testItem;
                    end
                end
                
                realProbabilityOfInfection = probabilityOfInfection;
                switch Q1(x, y)
                    case no_security_measures
                        % Nothing changes
                    case infecting
                        realProbabilityOfInfection = 2*realProbabilityOfInfection;
                    case self_protecting
                        % Nothing changes
                    case protecting_others
                        realProbabilityOfInfection = realProbabilityOfInfection/4;
                    case organizing_protection
                        realProbabilityOfInfection = realProbabilityOfInfection/8;
                end
                InfectNeighbours;
                
                % Self transitions (recovered or infected_and_sick)
                daysInfected = (iter - itersInQ2(x, y))/itersPerDay;
                if (daysInfected > 10) % Recover
                    [Q2, itersInQ2] = makeTransition([x, y], recovered, Q2, itersInQ2, iter);
                    todaysRecovered = todaysRecovered + 1;
                    confirmed(x,y) = 0;
                elseif (rand()*daysInfected*10 > 50) % Show symptoms
                    [Q2, itersInQ2] = makeTransition([x, y], infected_and_sick, Q2, itersInQ2, iter);
                end
                
            elseif (Q2(x, y) == sick)
                
                % Sick can be tested
                if (rand()*100 > 100-testingSickRate)
                    testItem;
                end
                
            elseif (Q2(x, y) == infected_and_sick)
                
                % Infected_and_sick can be tested
                if (rand()*100 > 100-testingSickRate)
                    testItem;
                end
                
                realProbabilityOfInfection = probabilityOfInfection*1.5;
                switch Q1(x, y)
                    case no_security_measures
                        % Nothing changes
                    case infecting
                        realProbabilityOfInfection = 2*realProbabilityOfInfection;
                    case self_protecting
                        % Nothing changes
                    case protecting_others
                        realProbabilityOfInfection = realProbabilityOfInfection/4;
                    case organizing_protection
                        realProbabilityOfInfection = realProbabilityOfInfection/8;
                end
                InfectNeighbours;
                
                % Go to hospital, recover or die
                daysInfectedAndSick = (iter - itersInQ2(x, y))/itersPerDay;
                randNumber = rand()*100;
                threshold = 80;
                if (randNumber > threshold)
                    if (randNumber > threshold+seriousCases+avgFatalityRate)
                        [Q2, itersInQ2] = makeTransition([x, y], recovered, Q2, itersInQ2, iter);
                        todaysRecovered = todaysRecovered + 1;
                        confirmed(x,y) = 0;
                    elseif (randNumber > threshold+seriousCases)
                        [Q2, itersInQ2] = makeTransition([x, y], dead, Q2, itersInQ2, iter);
                        todaysDeaths = todaysDeaths + 1;
                        confirmed(x, y) = 0;
                    elseif (randNumber > threshold && confirmed(x, y))
                        [Q2, itersInQ2] = makeTransition([x, y], in_hospital, Q2, itersInQ2, iter);
                        todaysInHospitalChange = todaysInHospitalChange + 1;
                    end
                end
                
            elseif (Q2(x, y) == in_hospital)
                
                daysInHospital = (iter - itersInQ2(x, y))/itersPerDay;
                randNumber = rand()*100;
                threshold = 50;
                if (randNumber > threshold)
                    if (randNumber > threshold+avgFatalityRate)
                        [Q2, itersInQ2] = makeTransition([x, y], recovered, Q2, itersInQ2, iter);
                        todaysRecovered = todaysRecovered + 1;
                        todaysInHospitalChange = todaysInHospitalChange - 1;
                        confirmed(x, y) = 0;
                    else
                        [Q2, itersInQ2] = makeTransition([x, y], dead, Q2, itersInQ2, iter);
                        todaysDeaths = todaysDeaths + 1;
                        todaysInHospitalChange = todaysInHospitalChange - 1;
                        confirmed(x, y) = 0;
                    end
                end
                
            elseif (Q2(x, y) == recovered)
                
                daysFromRecovery = (iter - itersInQ2(x, y))/itersPerDay;
                if (daysFromRecovery == 30)
                    [Q2, itersInQ2] = makeTransition([x, y], healthy, Q2, itersInQ2, iter);
                end
                
            elseif (Q2(x, y) == dead)
                
                % Dead invokes no action
                
            end
        end
    end
    
    % Save daily values
    dailyConfirmedCases(iter) = todaysConfirmedCases;
    dailyActiveCasesChange(iter) = todaysInfected - todaysRecovered - todaysDeaths;
    dailyDeaths(iter) = todaysDeaths;
    dailyRecovered(iter) = todaysRecovered;
    dailyInHospitalChange(iter) = todaysInHospitalChange;
    dailyInfected(iter) = todaysInfected;
    dailyTests(iter) = todaysTests;
    
    % Update total values
    if iter == 1
        totalInfected(iter) = todaysInfected;
        totalDeaths(iter) = todaysDeaths;
        totalRecovered(iter) = todaysRecovered;
        totalInHospital(iter) = todaysInHospitalChange;
        activeCases(iter) = dailyActiveCasesChange(iter);
        totalTests(iter) = todaysTests;
        totalConfirmed(iter) = todaysConfirmedCases;
    else
        totalInfected(iter) = totalInfected(iter-1) + todaysInfected;
        totalRecovered(iter) = totalRecovered(iter-1) + todaysRecovered;
        totalDeaths(iter) = totalDeaths(iter-1) + todaysDeaths;
        totalInHospital(iter) = totalInHospital(iter-1) + todaysInHospitalChange;
        activeCases(iter) = activeCases(iter-1) + dailyActiveCasesChange(iter);
        totalTests(iter) = totalTests(iter-1) + todaysTests;
        totalConfirmed(iter) = totalConfirmed(iter-1) + todaysConfirmedCases;
    end
    
    visualize(f1, Q1, f2, Q2, iter/itersPerDay, X, Y);
    iter = iter + 1;
end


%% Ploting other 
days = iters./itersPerDay;

infectedPerDay = zeros(1, ceil(maxIter/itersPerDay));
for i = 1:maxIter
    infectedPerDay(ceil(i/itersPerDay)) = infectedPerDay(ceil(i/itersPerDay)) + dailyInfected(i);
end
% f3 = figure('Name','Daily infected','NumberTitle','off');
f3 = app.AxesFrance1;
plot([1: ceil(maxIter/itersPerDay)], infectedPerDay, 'LineWidth', 1, 'Parent', f3);
% xlabel('Dzień');
% ylabel('Wartość');
% title('Nowe zachorowania');

% f4 = figure('Name','Daily recovered vs Daily deaths','NumberTitle','off');
% plot(days, dailyRecovered); hold on;
% plot(days, dailyDeaths);
% legend('Recovered', 'deaths');
% title(sprintf('Total recovered: %d, Total deaths: %d', sum(dailyRecovered), sum(dailyDeaths)));

% f5 = figure('Name','Total infected','NumberTitle','off');
f5 = app.AxesFrance2;
plot(days, totalInfected, 'LineWidth', 1, 'Parent', f5);
% xlabel('Dzień');
% ylabel('Wartość');
% title('Całkowita liczba zachorowań');

% f6 = figure('Name','Active Cases','NumberTitle','off');
f6 = app.AxesFrance3;
plot(days, activeCases, 'LineWidth', 1, 'Parent', f6);
hold(app.AxesFrance3, 'on');
plot(days, totalRecovered, 'LineWidth', 1, 'Parent', f6);
plot(days, totalDeaths, 'LineWidth', 1, 'Parent', f6);
plot(days, totalConfirmed, 'LineWidth', 1, 'Parent', f6);
% legend('Active', 'Recovered', 'Deaths', 'Confirmed');
% xlabel('Dzień');
% ylabel('Wartość');

% f7 = figure('Name','In hospital','NumberTitle','off');
f7 = app.AxesFrance4;
plot(days, totalInHospital, 'LineWidth', 1, 'Parent', f7);
% xlabel('Dzień');
% ylabel('Wartość');
% title('Ilość chorych w szpitalu');
end

function [] = visualize(f1, Q1, f2, Q2, day, X, Y)
    day = floor(day);
    
    pcolor(Q1, 'Parent', f1);
%     title(sprintf("day: %d", day));
    
    pcolor(Q2, 'Parent', f2)
%     title(sprintf('day: %d', day));

    drawnow;
end
