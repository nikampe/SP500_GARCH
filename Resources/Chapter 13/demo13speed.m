%% demo13.m ==================================
% demo programs for chapter 13 of the MATLAB script
% peter.gruber@usi.ch, 2014-10-21

%% Measuring speed
A=randn(1000);
tic
inv(A);
toc

%% many ways to sum the numbers from 1 to N
N=1000;

% Loop
tic
total=0;
for k=1:N;
	total=total+k;
end
toc

% Vectors
tic
vec1=1:N;
vec2=ones(N,1);
total=vec1*vec2;
toc

% MATLAB function
tic
vec1=1:N;
total=sum(vec1);
toc

% Gauss’ formula
tic
total=N*(N+1)/2;
toc

%% Inefficient Monte Carlo simulation
clear
T=50; N=100; K=1;					% Setup. T time steps, N draws, K = strike.
paths=exp(cumsum(0.05*randn(T,N)));	% Geometric Brownian motion in one line.
val=paths(end,:)-K;					% Step 1 for option payoff
option=mean(val .* (val>0))			% Step 2 for option payoff
MCSE=std(option)
whos paths							% The variable paths uses 40kB

% Efficient Monte Carlo simulation
for k=1:N							
  path1=exp(cumsum(0.05*randn(T,1)));	% Geometric Brownian motion in one line.
  pathEnd(k)=path1(end)-K;				% Step 1 for option payoff
end
option=mean(pathEnd .* (pathEnd>0))		% Step 2 for option payoff
MCSE=std(option)
whos path*								% The variables path1 and pathEnd use 1.2kB

% *Excessivley efficient Monte Carlo simulation
% Overly optimized for memory usage, but works
MCsum=0;
MCsquare=0;
for k=1:N							
  path1=exp(cumsum(0.05*randn(T,1)));		% Geometric Brownian motion in one line.
  MCpayoff = (path1(end)-K) .* ((path1(end)-K)>0);
  MCsum = MCsum + MCpayoff;					% Step 1 for option payoff
  MCsquare = MCsquare + MCpayoff^2;			% Useful for MCSE
end
option=MCsum/N								% Step 2 for option payoff
MCSE=sqrt(MCsquare/N)
whos									    % Variables path1, MCsum, MCsquare, MCpayoff use 0.42kB

