% Option valuation using Monte Carlo techniques
% MatLab course 2007-06-15
% (c) Peter Gruber

% We use the convention that one event is one column

% Here are all parameters for all parts:
Nturns   = 1000;                        % We run the MC that many times
Duration = 90/360;                      % Time to expiry of option, 3 Months
Nsteps   = 62;                          % We do 62 steps ... about one per trading day
dt       = Duration / Nsteps;           % Time in years between steps
r        = 0.02;                        % risk-free rate
S_0      = 216;                         % Today's stock price
X        = 210;                         % strike price

%% First we estimate the historic volatility
% See HULL: Options, Futures and other Derivatives, section 12.4, p. 239
roche=csvread('roche.csv',1,1);         % Read daily data from ROCHE
data=roche(:,6);                        % The data that we need is in 6th row
ret=log(data(2:end)./data(1:end-1));    % Calculate log returns 
vola = sqrt(var(ret))*sqrt(252);        % Volatility = stdv of returns
                                        % Yearly volatility ... scale by sqrt(252) 
                                        % because there are 252 trading days per year

%% Next, we do the Monte Carlo simulation
% See HULL: Options, Futures and other Derivatives, section 18.6, p. 410

% Diffusion term
diff  = randn(Nsteps, Nturns) * vola * sqrt(dt);

% drift per step + Diffusion
dVal  = 1 + r*dt + diff;

% Price paths
S     = S_0 * cumprod(dVal,1);

%% Plot a few trajectories
maxplot = min(50,size(S,2));           % Plot max. 100 trajectories
plot(S(:,1:maxplot));

%% Last, we value the option
% For the payoffs, only the last day counts
payoffC = exp(-r*Duration)*(S(end,:) - X);
% Any negative payoffs are set to zero
payoffCall = payoffC .* (payoffC>0);

%% To valuate the option, we calculte the mean
disp('MC price:');
C = mean(payoffCall)

%% Finally, we check with the BlackScholes-Formula
[c,p,d1,d2] = OptionBlackPS(S_0,X,Duration,r,vola);
disp('BS-Price:');
disp(c);