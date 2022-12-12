% interpolation_hf
% peter.gruber@usi.ch, 2013-02-01

% setup

% create a high-frequency data set, sampled every 15 seconds
% 1 trading day = 8 hours = 480 mins = 1921 data points
% for simplicity mu=0;
sigma = 0.20 / sqrt(252) / sqrt(1921);

npoints15 = 1921;               % number of poins
r0=sigma*randn(npoints15,1);    % 15 sec returns
y15  = exp(cumsum(r0));         % tick price data
x15  = 15*(0:npoints15-1);      % tick times
plot(x15,y15)                   % plot
hold on

% calculate returns and annualized sigma
retn = log(y15(2:end))-log(y15(1:end-1));
sigmaHat15=sqrt(var(retn)*252*npoints15)

% now we interpolate to 5 second intervals
npoints5 = 1920*3+1;                    % number of poins
x5 = 5*(0:npoints5-1);                  % new tick points
y5 = interp1(x15,y15, x5, 'linear');    % interpolation
plot(x5,y5,'r--')                       % plot exactly on top of 15s interval
retn = log(y5(2:end))-log(y5(1:end-1));
sigmaHat5=sqrt(var(retn)*252*npoints5)

% now we interpolate to 1 second intervals
npoints1 = 1920*15+1;                   % number of poins
x1 = 1*(0:npoints5-1);                  % new tick points
y1 = interp1(x15,y15, x1, 'linear');    % interpolation
retn = log(y1(2:end))-log(y1(1:end-1));
sigmaHat1=sqrt(var(retn)*252*npoints1)

% would the same thing have happend with nearest neighbour interpolation?
y1NN = interp1(x15,y15, x1, 'nearest'); % nearst neighbour interpolation
retn = log(y1NN(2:end))-log(y1NN(1:end-1));
sigmaHat1NN=sqrt(var(retn)*252*npoints1)


% Extra question: and if we had eliminated points?
% try a 60s grid
npoints60 = 1920/4+1;                  % number of poins
x60 = 60*(0:npoints60-1);              % new tick points
y60 = interp1(x15,y15, x60, 'linear'); % this is called "interpolation", but
                                       % actually we eliminate points
plot(x60,y60,'k--')                    % plot is now different (need to zoom in)
retn = log(y60(2:end))-log(y60(1:end-1));
sigmaHat60=sqrt(var(retn)*252*npoints60)


