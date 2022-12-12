% manydice.m
% The result of a simulation is a random variable
% This program produces Figure 6.1 in the script
% (c) 2007 peter.gruber@unisg.ch 

clear;
n    = 100;                    % Number of dice throws *per simulation* ("sampe size") 
sims = 10000;                 % Number of *simulations* ("simulation size")

for i=1:sims                  % This loop generates n dice realizazions sims times
  dice = ceil(6*rand(1,n));   % Inside the loop, there is ONE simulation of n IID draws of the dice
  result(i) = mean(dice);     % Inside the loop, one result is the mean of a single simulation of n draws
end

subplot(1,2,1);               % Make 1 row, 2 colums of plots; select first one
hist(result,3:0.03:4);        % Make a histogram of the distribution of the sample mean realizations
                              % from drawing the dice
axis([3 4 0 2000]);           % Fix a common scale
title('n=100');               % Add a title


%% Now we repeat the whole exercise for n=1000
n    = 1000;                 % Number of dice throws *per simulation* ("sampe size") 

for i=1:sims                  % This loop generates n dice realizazions sims times
  dice = ceil(6*rand(1,n));   % Inside the loop, there is ONE simulation of n IID draws of the dice
  result(i) = mean(dice);     % Inside the loop, one result is the mean of a single simulation of n draws
end

subplot(1,2,2);               % Select second subplot
hist(result,3:0.02:4);        % Make a histogram of the distribution of the sample mean realizations
                              % from drawing the dice
axis([3 4 0 2000]);           % Fix a common scale
title('n=1000');              % Add a title

