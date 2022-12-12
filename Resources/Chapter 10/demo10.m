%% Demo 10
% Code for the MATLAB course
% peter.gruber@usi.ch
% started 2008-09-01

%% Example: grid search
ff=@(x) x.^ 2 - x + 2;
x0   = linspace(-10,10,1000); 
ytry = ff(x0);
pos  = find(ytry==min(ytry)); 
min  = x0(pos);


%% Example for fminsearch fooled by local minimum
clear;clc;
hold off
f = @(x)x.^2+0.1*cos(20*x);
% f = @(x)sin(x)+0.2*sin(10*x);
fplot(f,[-2,2])
%fplot(f,[1,6])
hold on
%% trial 1
x0=2;
x_min=fminsearch(f,x0)
plot([x0 x_min],[f(x0) f(x_min)],'dr:','LineWidth',3,'MarkerSize',10)

%% trial 2
x0=0.7;
x_min=fminsearch(f,x0)
plot([x0 x_min],[f(x0) f(x_min)],'dg:','LineWidth',3,'MarkerSize',10)

%% trial 3
x0=0.9;
x_min=fminsearch(f,x0)
plot([x0 x_min],[f(x0) f(x_min)],'db:','LineWidth',3,'MarkerSize',10)

%% trial 4
x0=1.5;
x_min=fminsearch(f,x0)
plot([x0 x_min],[f(x0) f(x_min)],'dk:','LineWidth',3,'MarkerSize',10)

%% Multidimensional function R^2 -> R
f=@(x,y)(x-1).^2+(y+1).^2		% A nice hyperbola
[X,Y]=meshgrid(-8:.5:8);		% Prepare for a 3D plot
Z=f(X,Y);						% Calculate all z-values
mesh(X,Y,Z)						% Nice 3D plot
surfc(X,Y,Z)					% Note the isolines on the xy-surface.
contour(X,Y,Z)
fminsearch(f,[0,0])				% Let us try to minimize f – we get an error message.
f=@(v)(v(1)-1)^2+(v(2)+1)^2		% Rewrite in vector format: x = v(1); y = v(2).
fminsearch(f,[0,0])				% Now it works and we get a vector result.
 
opt = optimset('TolX',1E-8,'Display','iter')
fminsearch(f,[0,0],opt)


%% Fminunc with explicit gradient
options = optimset(’GradObj’,’on’);
fminunc(@myfun,[1;1], options)


%% Optimizing a stochastic function
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



