function [] = simulation_real(app)

% Czasy symulacji
dt = 0.1; % time step
time1 = datetime(2020,01,01,0,0,0):dt:datetime(2020,06,01,0,0,0);
N = numel(time1);
t = [0:N-1].*dt;

%Npop= 5368000; % populacja - ponad 5 milionów
Npop=app.populationModel.Value;
%%%%%%%%Początkowe ilości osób znajdujących się w danym stanie
% NSM0=0; 
% SP0=0;  
% INF0=200;
% IAS0=100;
% REC0=10;
% Q0=200;
% INH0=100;
% D0=10;

NSM0=app.NSM0.Value; 
SP0=app.SP0.Value;  
INF0=app.INF0.Value;
IAS0=app.IAS0.Value;
REC0=app.REC0.Value;
Q0=app.Q0.Value;
INH0=app.INH0.Value;
D0=app.D0.Value;


% a=0.4; %wskaźnik zmiany zachowania na niestosowanie środków ochrony
% b=0.01; %wskaźnik zmiany zachowania na stosowanie środków ochrony
% alfa=0.9; %wskaźnik zachorowania osoby która nie stosowała środków ochrony
% beta=0.5; %wskaźnik zachorowania osoby, która stosowała środki ochrony
% gamma=0.2; %wskaźnik pojawienia się objawów choroby
% c=0.12; %wskaźnik przejścia do kwarantanny osób bez objawów
% d=0.32; %wskaźnik przejścia do kwarantanny osób z objawami
% lambda=0.7; %wskaźnik przejścia do szpitala osób z objawami
%ot=[0.01 0.1 100]; %wskaźnik wyleczeń osób w kwarantannie(zależy od czasu)
% lt=[0.01 0.1 100]; % wskaźnik wyleczeń osób ze szpitala(zależy od czasu)
%ft=[0.001 0.01 30]; %śmiertelność(zależy od czasu)

testRate = app.ModelTestRate.Value; %wykorzystywane w sterowaniu
a=app.a.Value; %wskaźnik zmiany zachowania na niestosowanie środków ochrony
b=app.b.Value; %wskaźnik zmiany zachowania na stosowanie środków ochrony
alfa=app.alfa.Value; %wskaźnik zachorowania osoby która nie stosowała środków ochrony
beta=app.beta.Value; %wskaźnik zachorowania osoby, która stosowała środki ochrony
gamma=app.gamma.Value; %wskaźnik pojawienia się objawów choroby
c=app.c.Value; %wskaźnik przejścia do kwarantanny osób bez objawów
d=app.d.Value; %wskaźnik przejścia do kwarantanny osób z objawami
lambda=app.lambda.Value; %wskaźnik przejścia do szpitala osób z objawami

 ot=zeros(3,1); %wskaźnik wyleczeń osób w kwarantannie(zależy od czasu)
 ot(1)=app.o1.Value;
 ot(2)=app.o2.Value;
 ot(3)=app.o3.Value;

 lt=zeros(3,1); % wskaźnik wyleczeń osób ze szpitala(zależy od czasu)
 lt(1)=app.l1.Value;
 lt(2)=app.l2.Value;
 lt(3)=app.l3.Value;

 ft=zeros(3,1); %śmiertelność(zależy od czasu)
 ft(1)=app.f1.Value;
 ft(2)=app.f2.Value;
 ft(3)=app.f3.Value;


%funkcje opóźnień
oFun=@(x,t) x(1)./(1+exp(-x(2)*(t-x(3))));
lFun=@(x,t) x(1)./(1+exp(-x(2)*(t-x(3))));
fFun=@(x,t) x(1).*exp(-(x(2)*(t-x(3))).^2);

[H,NSM,SP,INF,IAS,Q,INH,REC,D] = solving_equations(testRate,a,b,alfa,beta,gamma,c,d,lambda,ot,lt,ft,Npop,SP0,NSM0,INF0,IAS0,REC0,Q0,INH0,D0,t,oFun,lFun,fFun);

%% Robocze przykładowe wyświetlenie ilości zdrowych osób od czasu
% figure 
% plot(t,H,'b');
 plot(t,D,'b','Parent', app.Diffdeathsnum);
 plot(t,REC,'b','Parent', app.Diffrecnum);
% %%%Robocze przykładowe wyświetlenie wskaźnika wyzdrowienia z kwarantanny i
% %%śmiertelności
% figure
% plot(t,oFun(ot,t),'b',t,fFun(ft,t),'k')
% legend('Współczynnik wyzdrowienia osoby z kwarantanny','Współczynnik śmiertelności','location','best');
% xlabel('Time (days)')
% set(gcf,'color','w')
% 
% figure;
% plot(t, REC);

plot(t, D, 'Parent', app.AxesModelDead);
% plot(t, totalInfected, 'Parent', app.AxesModelInfected);
plot(t, INF, 'Parent', app.AxesModelInfected)
plot(t, REC, 'Parent', app.AxesModelRecovered);



end

