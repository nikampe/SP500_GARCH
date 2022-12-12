function FTrp = intTrapezoidal(f,xLow,xHigh,Npoint);

% intTrapezoidal implements a simple trapezoidal rule numerical integration
% INPUT  f ..... function handle
%        xLow .. lower integration boundary
%        xHigh . upper integration boundary
%        Npoint. Number of integration steps
%
% OUTPUT FTrp ..... Approximation of the integral
%
% HSG MATLAB course 2012
% peter.gruber@usi.ch, 2012-12-10

dx      = (xHigh-xLow) / Npoint;	        % x-increment (="width of strips")
xTrp    = xLow : dx : xHigh;	            % x values
yTrp    = f(xTrp);							% Function values 
weights = [0.5 ones(1,Npoint-1) 0.5];      % weights
FTrp    = dx*sum(yTrp .* weights );         % trapezoidal integral

end