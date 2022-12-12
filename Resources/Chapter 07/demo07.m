%% MATLAB sample code SECTION 7
% peter.gruber@usi.ch

clear
format short

%% Rolling a dice in MATLAB
dice = randi(6)
dice = ceil(6*rand) 

%% Seeds for the random number generator
myRand = rng            % Get state (seed) of random number generator
rand(1,5)               % 5 random numbers
rand(1,5)               % 5 different ones
rng(myRand);            % Reset random number generator
rand(1,5)               % Same 5 random numbers
rng(sum(100*clock))     % Unique initialization

%% Binomial
p = 0.7;                % Probability of success
n = 3;                  % Number of tries
myRand = rand(1,n)      % Random draw
myRand<=p               % Individual successes 
sum(myRand<=p)          % Binomial = number of successes 

%% Discrete random variable: probability function of X
x=[1,2,3,4];                    % Values of random variable X 
p=[0.2 0.1 0.4 0.3];            % Small p: values of probability function p(1) ... p(4) 
stem(x,p, 'LineWidth',2 );      % Plot probability function
axis([0 5 0 0.5]);

%% Discrete random variable: distribution function of X
% Need to add one value with zero probability to the left and right for
% nicer plotting
P=cumsum(p);                    % Large P: values of distribution function P(1),..,P(4)
xex=[0 x 5]; Pex=[0 P 1];       % Extended scale for plotting
stairs(xex,Pex,'LineWidth',2 ); % Plot distribution function on extended scale
axis([0 5 0 1.1]);

%% Discrete random variable: simulate one random number for X
r=rand;                         % Save random number for next two lines 
sum(r>P)+1                      % Discrete random value 
r>P                             % What did we do? 

%% Produce 1000 random draws from the above discrete distribution for X
for k=1:1000                    % As a short verification, ... 
    dist(k)=sum(rand>P)+1;      % we produce 1000 random draws 
end 
hist(dist, [1:4])               % Plot a histogram of the resulting empirical distribution

%% A different support for X, but with identical probabilities
x=[-1.1 0 3.2 17];              % Define possible values of X as a function of index i=1,..,4
x(sum(rand>P)+1)                % Simulate one random number X(i) with the 
                                % above probabilities for index i=1,..,4

%% Produce 1000 random draws from the above discrete distribution for X 
for k=1:1000             
    dist(k)=x(sum(rand>P)+1);
end 
hist(dist,x);                             % Plot a histogram of the resulting empirical distribution
%% Probability function of X
stem(x,p, 'LineWidth',2 );                % Plot probability function of X
axis([-2 20 0 0.5]);

%% Distribution function of X
stairs([-2 x 20], Pex,'LineWidth',2)      % Plot distribution function of X
axis([-2 20 0 1.1]);

%% An example for a continuous distrubution
N=1000;
x=randn(N,1);
hist(x,20)
[mean(x) std(x) kurtosis(x) skewness(x)]

%% What is the distribution of the cdf values of x?
X=normcdf(x);
hist(X); 

%% Was this a coincidence? Or can we use this in general?
u=rand(N,1);         % now uniformly distributed
x1=norminv(u);
hist(x1);
[mean(x1) std(x1) kurtosis(x1) skewness(x1)]

%% (Continuous) Pareto distribution function
alpha=0.5;                                % Pareto distribution parameter
parCDF=@(x,alpha) 1-(1+x).^-alpha;        % Pareto distribution function with parameter alpha
N=1000;
Xi=linspace(0,300,N);                     % Split [0,100] interval in N steps of size 100/N
plot(Xi, parCDF(Xi,alpha));               % Plotting the distribution function
axis([0 300 0 1]);

%% Pareto inverse distribution function
parICDF=@(x,alpha) (1-x).^(-1/alpha)-1;   % Inverse Pareto distribution function
Xi=linspace(0,1,N);                       % Split [0,1] interval in steps of size 1/N
plot(Xi, parICDF(Xi,alpha));              % Plotting the inverse Pareto distribution function
axis([0 1 0 300]);

%% Verifying the definition of the inverse distribution function I
plot(parICDF(Xi,alpha), Xi);              % First check: plot the inverse Pareto distribution function
axis([0 300 0 1]);                        % function on a reversed scale

%% Verifying the definition of the inverse distribution function II
Xi=linspace(0,300,N);                      
plot(Xi, parICDF(parCDF(Xi,alpha),alpha)); % Second check: definition of the inverse implies a
axis([0 300 0 300]);                       % plot of the identity function
hold off;

%%  Pareto drawing using the inverse distribution function
% Simulated empirical distribution function vs. theoretical one
paretoDraw=@(alpha) parICDF(rand,alpha)         % Matlab function for a single Pareto draw
paretoDrawN=@(alpha,N) parICDF(rand(N,1),alpha) % Matlab function for N IID Pareto draws
myDraw=paretoDrawN(alpha,N);                    % Simulate N Pareto random numbers
Xi=linspace(0,1,N);                             % Split [0,1] interval in N steps of size 1/N
plot(sort(myDraw),Xi,'r--')                      % Plot of the empirical distribution function
axis([0 350 0 1]);
hold on
Xi=linspace(0,350,N);
plot(Xi, parCDF(Xi,alpha));                     % Plot of the theoretical distribution function
hold off;


%% Simulation of a single path of a discrete time standard Brownian motion
x(1)=0;                    % Process initialization: use x(1) for x_0, because there is no x(0) in Matlab 
for t=2:1000               % Loop over time, start with t=2. 
    x(t)=x(t-1)+randn;     % A single trajectory of 1000 observations from discrete time standard Brownian motion 
end
plot(x)                    % Plot of the simulated trajectory

%% Simulation of a single variance path of a GARCH model
a1=0.1; b1=0.85; w=0.01;                             % Set the GARCH parameters (a1+b1 <1 for stationarity!) 
e(1)=0.01; s(1)=sqrt(w);                               % Set the initial values for e_0 and sigma_0
for t=2:1000                                        % Simulate the process 
    s(t)=sqrt(w+a1*e(t-1)^2 + b1*s(t-1)^2);         % Loop over time, start with t=2.
    e(t)=s(t)*randn;                                % A single trajectory of 1000 observations from a GARCH model
                                                    % Note: the updating order is important: first s(t), then e(t) 
end
figure
subplot(2,1,1);                                     % Make 2 rowa, 1 colums of plots; select first one
plot(e);                                            % Plot of the simulated trajectory for e_t
subplot(2,1,2);                                     % Select second plot
plot(s);                                            % Plot of the simulated trajectory for s_t
hold off;

%% Simulation of three Ornstein-Uhlenbeck processes
kappa=0.01; theta=0.5; v=0.1;
x=[-5;0;5];
for t=2:150
  x(:,t)=x(:,t-1)+kappa.*(theta-x(:,t-1))+v.*randn(3,1);
end
figure
plot(x')


%% First step Monte Carlo
N=100;                          % Good style: define n in the beginning 
dice=ceil(6*rand(1,N));         % Roll n dices in one line 
disp(mean(dice));               % Run this cell several times, observe the result
                                % Change N to 1000 and 10000 and run again several
                                % times
                                

