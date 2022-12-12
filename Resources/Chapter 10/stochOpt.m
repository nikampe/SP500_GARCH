% stochOpt.m
% A small example to illustrate optimizing a stochastic function

% We want to find E(x) with x~U(0,1,) by minimizing the function
% f(theta)=(1/N*sum(x) - theta)^2

%% Illustration
x=0.4:0.001:0.6;
N=1000;

for u=1:length(x)
  err(u)=(mean(rand(N,1))-x(u))^2;
end

mydist=rand(N,1);
for u=1:length(x)
  err2(u)=(mean(mydist)-x(u))^2;
end

plot(x,err,'r:')
hold on
plot(x,err2,'k')

%% Grid search
[val,pos]=min(err);
fprintf('Minimum naive:    %6.4f\n',x(pos))
[val,pos]=min(err2);
fprintf('Minimum advanced: %6.4f\n',x(pos))

%% fminsearch minimization
fNaive=@(theta)(mean(rand(N,1))-theta)^2;
mydist=rand(N,1);
fAdvanced=@(theta)(mean(mydist)-theta)^2;
options = optimset('Display','iter','TolX',1E-6);
fminsearch(fNaive,0.4,options)
fminsearch(fAdvanced,0.4,options)

%% simulation exercise
fNaive=@(theta)(mean(rand(N,1))-theta)^2;
options = optimset('Display','off','TolX',1E-6);
x0=0.6;      % try to change x0
for d=1:500
    mydist=rand(N,1);
    fAdvanced=@(theta)(mean(mydist)-theta)^2;
    thetaNaive(d,1)=fminsearch(fNaive,x0,options);
    thetaAdvanced(d,1)=fminsearch(fAdvanced,x0,options);
end
hist([thetaNaive,thetaAdvanced])
legend('Naive','Advanced')

