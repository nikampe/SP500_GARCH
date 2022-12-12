%% demo13.m ==================================
% demo programs for chapter 13 of the MATLAB script
% peter.gruber@usi.ch, 2014-10-21

%% Setup (create data to be used later on)
a=1000;
delta=0.05
x=rand(100,1);
beta=1;
y=x*beta+0.05*randn(100,1);
x1=x.';

%% Incomplete list of frequent MATLAB errors
%  Correct the errors

%% Missing brackets
a^1+delta

%% Wrong order of brackets
% sum of squared errors
sum(y-x*beta)^2       

%% Mixing row and column vectors
y-x1

%% Equality with real numbers
a=mean(randn(10000,1))
if a==0
	disp('equal')
end

%% Manually calculated values
b=1.67
b^0.33

%% Logical conditions with matrices
a=randn(3)           
if a>0
  disp('larger than zero')
end               
if a<0
  disp('smaller than zero')
end    

%% Typo in name of variable
part1=1;
part2=1;
part3=1;
sum = part1;          
Sum = sum+part2;
sum = sum+part3

%% Improper initialization
stock(1)=100;
for k=2:1000
stock(k)=stock(k-1)*(1+randn*0.01);
end
plot(stock);
stock(1)=25;
for k=2:100
stock(k)=stock(k-1)*(1+randn*0.01);
    stock(k)=stock(k-1)*(1+randn*0.03);
end
plot(stock);