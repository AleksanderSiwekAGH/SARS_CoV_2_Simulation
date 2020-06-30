%% Size

% X = 100;
% Y = 100;
% maxIter = 20;
itersPerDay = 5;

%% States

% Q1:
no_security_measures = 1;
infecting = 2;
self_protecting = 3;
protecting_others = 4;
organizing_protection = 5;

% Q2:
healthy = 1;
in_quarantine = 2;
infected = 3;
sick = 4;
infected_and_sick = 5;
in_hospital = 6;
recovered = 7;
dead = 8;

% Allowed {Q1, Q2} states:
allowed_states = [1 0 1 1 1 0 1 1
                  0 0 1 0 1 1 0 0
                  1 1 1 1 1 1 1 0
                  1 1 1 1 1 1 1 0
                  1 1 1 1 1 1 1 0];

%% Transition matrices

% Q1 allowed transitions:
Q1_trans = [0 1 1 0 0
            0 0 0 1 0
            0 0 0 1 0
            0 0 1 0 1
            0 0 0 1 0];

% Q2 allowed transitions:
Q2_trans = [0 1 1 1 0 0 0 0
            1 0 0 1 0 0 0 0
            0 0 0 0 1 0 1 0
            1 0 1 0 0 0 0 0
            0 0 0 0 0 1 1 1
            0 0 0 0 1 0 1 1
            0 1 1 1 0 0 0 0
            0 0 0 0 0 0 0 0];

% Temp change -  recovered cannot be infected again ?
% Q2_trans = [0 1 1 1 0 0 0 0
%             1 0 0 1 0 0 0 0
%             0 0 0 0 1 0 1 0
%             1 0 1 0 0 0 0 0
%             0 0 0 0 0 1 1 1
%             0 0 0 0 1 0 1 1
%             0 1 0 1 0 0 0 0 
%             0 0 0 0 0 0 0 0];

 %% Probabilities and other assumptions
 
 timeConstant = 10; % Days in which (on average) things escalate
 probabilityOfInfection = 5; % [%]
 recoveryDay = 10; % Average time it takes to recover
 dieOrRecoverDay = 10;
 avgFatalityRate = 1; % [%]
 howMuchPatientsZero = 10;
 seriousCases = 5; % [%]
%  testingRate = 60; % [%]
%  testingSickRate = 60; % [%]
 testingNotSickThreshold = 0.5;
%  selfProtectingThreshold = 10;
%  protectingOthersThreshold = 20;
%  organizingProtectionThreshold = 30;