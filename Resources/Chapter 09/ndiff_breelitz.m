% ndiff_breelitz
% A quick implementation of the Breeden and Litzenberger (Journal of Busisness 1978) formula
% q(K)=d^2C/dK^2
% peter.gruber@usi.ch

clear
load optiondata
data=optiondata;          % underlying was 1455
K=optiondata(:,1);        % strikes
C=optiondata(:,2);        % call prices
plot(K,C)
title('Call price as function of strike K')

%% first derivative
C1=diff(C)./diff(K);
K1=1/2*(K(1:end-1)+K(2:end));
plot(K1,C1)
title('First derivative')


%% second derivative
C2=diff(C1)./diff(K1);
K2=1/2*(K1(1:end-1)+K1(2:end));
plot(K2,C2)
title('Second derivative')


%% polynomial approximation
P = polyfit(K,C,8);
plot(K,C-polyval(P,K),':')
title('approximation error in price')

%% first derivative
polydiff=@(p)p(1:end-1).*(length(p)-1:-1:1);
P1=polydiff(P);
plot(K,polyval(P1,K))
title('First derivative')


%% second derivative
P2=polydiff(polydiff(P));
plot(K,polyval(P2,K))
title('Second derivative')


%% trying with some BS prices
hold off
S=1436.78;
r=0.0609;
tau=0.21;
sigma= 0.248;
Kbs=1000:1:2000;
Cbs=OptionBlackPG(S,Kbs,tau,r,sigma);
bsprice=[Kbs' Cbs'];
Kbs=bsprice(:,1);
Cbs=bsprice(:,2);
plot(K,C);hold on
plot(Kbs,Cbs,'--')
plot(K,polyval(P,K),'r--')
legend('Data','Black-Scholes','Polynomial approx','Location','NorthWest')
title('Prices')
hold off
 
%% first derivative
Cbs1=diff(Cbs)./diff(Kbs);
Kbs1=1/2*(Kbs(1:end-1)+Kbs(2:end));
plot(Kbs1,Cbs1)
hold on
plot(K1,C1,':')
plot(Kbs,polyval(P1,Kbs),'r--')
legend('Black-Scholes','Breeden-Litzenberger','Polynomial approx','Location','NorthWest')
title('First derivative')
hold off

%% second derivative
Cbs2=diff(Cbs1)./diff(Kbs1);
Kbs2=1/2*(Kbs1(1:end-1)+Kbs1(2:end));
plot(Kbs2,Cbs2)
hold on
plot(K2,C2,':')
plot(Kbs,polyval(P2,Kbs),'r--')
legend('Black-Scholes','Breeden-Litzenberger','Polynomial approx','Location','NorthWest')
title('Second derivative')
%axis([800 1800 -0.008 0.01])

%% bonus fit first order derivative and differentiate
Px=polyfit(K1,C1,5);
plot(Kbs1,Cbs1)
hold on
plot(K1,C1,':')
plot(Kbs,polyval(P1,Kbs),'r--')
plot(Kbs,polyval(Px,Kbs),'r-.')
legend('Black-Scholes','Breeden-Litzenberger','Polynomial approx','Mixed','Location','NorthWest')
hold off
title('First derivative')
axis([800 2000 -1.1 0.0])

%%
P1x=polydiff(Px);
plot(Kbs2,Cbs2)
hold on
plot(K2,C2,':')
plot(Kbs,polyval(P2,Kbs),'g--')
plot(Kbs,polyval(P1x,Kbs),'r-.')
legend('Black-Scholes','Breeden-Litzenberger','Polynomial approx','Mixed','Location','NorthWest')
hold off
title('Second derivative')
axis([1100 1800 -0.003 0.005])