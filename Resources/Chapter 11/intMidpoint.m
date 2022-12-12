function FMid = intMidpoint(f,xLow,xHigh,Npoint);

% intMidpoint implements a simple midpoint numerical integration
% INPUT  f ..... function handle
%        xLow .. lower integration boundary
%        xHigh . upper integration boundary
%        Npoint. Number of integration steps
%
% OUTPUT FMid .. Approximation of the integral
%
% HSG MATLAB course 2012
% peter.gruber@usi.ch, 2012-12-10

dx   = (xHigh-xLow) / Npoint;	        % x-increment (="width of strips")
xMid = (xLow+dx/2) : dx : (xHigh-dx/2);	% midpoint values
yMid = f(xMid);							% Function values 
FMid = sum(yMid*dx);				    % midpoint rule integral

end