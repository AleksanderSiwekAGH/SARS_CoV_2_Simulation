function [H,NSM,SP,INF,IAS,Q,INH,REC,D] = solving_equations(testRate,baseA,baseB,alfa,beta,gamma,c,d,lambda,ot,lt,ft,Npop,SP0,NSM0,INF0,IAS0,REC0,Q0,INH0,D0,t,oFun,lFun,fFun)

%Warunki początkowe
N = numel(t);
Y = zeros(9,N);
Y(1,1) = Npop-SP0-NSM0-INF0-IAS0-REC0-Q0-INH0-D0;
Y(2,1) = SP0;
Y(3,1) = NSM0;
Y(4,1) = INF0;
Y(5,1) = IAS0;
Y(6,1) = REC0;
Y(7,1) = Q0;
Y(8,1) = INH0;
Y(9,1) = D0;

if round(sum(Y(:,1))-Npop)~=0
    error(['the sum must be zero because the total population',...
        ' (including the deads) is assumed constant']);
end
%% Wylicza stany
modelFun = @(Y,A,F) A*Y + F;
dt = median(diff(t));
o=oFun(ot, t);
l=lFun(lt, t);
f=fFun(ft, t);

% obliczanie  ODE 
for ii=1:N-1
    % Sterowanie poprzez zmiany współczynników a i b
    infected = Y(4,ii) + Y(5,ii) + Y(6,ii) + Y(7,ii); % TODO tutaj trzeba zsumować wszystkie stany infected
    [aModifier, bModifier] = countAandB(testRate, infected, Npop);
    a = baseA * aModifier; % TODO  
    b = baseB * bModifier; % TODO
    
    A = getA(alfa,beta,c,gamma,d,lambda,o(ii),l(ii),f(ii));
    HINF = Y(1,ii)*Y(4,ii);
    F = zeros(9,1);
    F(1,1) = (-a/Npop).*HINF +(-b/Npop).*HINF;
    F(2,1) = a/Npop.*HINF;
    F(3,1) = b/Npop.*HINF;
    Y(:,ii+1) = RK4(modelFun,Y(:,ii),A,F,dt);
end

%% Zapisanie wyniku
H = Y(1,1:N);
NSM = Y(2,1:N);
SP = Y(3,1:N);
INF = Y(4,1:N);
IAS = Y(5,1:N);
Q = Y(6,1:N);
INH = Y(7,1:N);
REC = Y(8,1:N);
D = Y(9,1:N);

%Uzyskanie macierzy A do obliczenia równania
    function [A] = getA(alfa,beta,c,gamma,d,lambda,o,l,f)
        %   A: matrix: [9x9]
        A = zeros(9);
       
        A(1,1) = 0;
        
        A(2,2) = -alfa;
        
        A(3,3) = -beta;
        
        A(4,2:4) = [alfa,beta,-c-gamma];
        
        A(5,4:5) = [gamma,-d-lambda];
        
        A(6,4:6) = [c,d,-o];
        
        A(7,5:2:7) = [lambda,-l-f];
        
        A(8,6:7)= [o,l];
        
        A(9,7)=f;
    end
    function [Y] = RK4(Fun,Y,A,F,dt)
        % Runge-Kutta 
        k_1 = Fun(Y,A,F);
        k_2 = Fun(Y+0.5*dt*k_1,A,F);
        k_3 = Fun(Y+0.5*dt*k_2,A,F);
        k_4 = Fun(Y+k_3*dt,A,F);
        % wynik
        Y = Y + (1/6)*(k_1+2*k_2+2*k_3+k_4)*dt;
    end
end

function [a, b] = countAandB(testRate, infected, maxPop)
    T = 0.08;
    fun = @(t) 0.9 - 0.8*exp(-t/T);
    b = fun(testRate*infected/maxPop);
    a = 1 - b;
end