clearvars;close all;clc;
% Czasy symulacji
dt = 0.1; % time step
time1 = datetime(2020,01,01,0,0,0):dt:datetime(2020,06,01,0,0,0);
N = numel(time1);
t = [0:N-1].*dt;

Npop= 5368000; % populacja - ponad 5 milionów

%%%%%%%%Początkowe ilości osób znajdujących się w danym stanie
NSM0=0; 
SP0=0;  
INF0=200
IAS0=100
REC0=10;
Q0=200;
INH0=100
D0=10;

a=0.1 %wskaźnik zmiany zachowania na niestosowanie środków ochrony
b=0.08 %wskaźnik zmiany zachowania na stosowanie środków ochrony
alfa=0.8 %wskaźnik zachorowania osoby która nie stosowała środków ochrony
beta=0.3 %wskaźnik zachorowania osoby, która stosowała środki ochrony
gamma=0.5 %wskaźnik pojawienia się objawów choroby
c=0.2 %wskaźnik przejścia do kwarantanny osób bez objawów
d=0.5 %wskaźnik przejścia do kwarantanny osób z objawami
lambda=0.7 %wskaźnik przejścia do szpitala osób z objawami
ot=[0.01 0.1 100]; %wskaźnik wyleczeń osób w kwarantannie(zależy od czasu)
lt=[0.01 0.1 100]; % wskaźnik wyleczeń osób ze szpitala(zależy od czasu)
ft=[0.001 0.01 60]; %śmiertelność(zależy od czasu)

%funkcje opóźnień
oFun=@(x,t) x(1)./(1+exp(-x(2)*(t-x(3))));
lFun=@(x,t) x(1)./(1+exp(-x(2)*(t-x(3))));
fFun=@(x,t) x(1).*exp(-(x(2)*(t-x(3))).^2);

[H,NSM,SP,INF,IAS,Q,INH,REC,D] = solving_equations(a,b,alfa,beta,gamma,c,d,lambda,ot,lt,ft,Npop,SP0,NSM0,INF0,IAS0,REC0,Q0,INH0,D0,t,oFun,lFun,fFun);
%%%Robocze przykładowe wyświetlenie ilości zdrowych osób od czasu
figure 
plot(t,H,'b');
%%%Robocze przykładowe wyświetlenie wskaźnika wyzdrowienia z kwarantanny i
%%śmiertelności
figure
plot(t,oFun(ot,t),'b',t,fFun(ft,t),'k')
legend('Współczynnik wyzdrowienia osoby z karantanny','Współczynnik śmiertelności','location','best');
xlabel('Time (days)')
set(gcf,'color','w')



