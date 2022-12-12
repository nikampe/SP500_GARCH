function y = ccinterest(r,t) 
% Calculates the continuously  compouned interest on 1 Euro. 
%
% INPUT	 r	1x1 .. interest rate
%        t	1x1 .. time in yrs
% OUTPUT y  1x1 .. payoff
%
% USAGE ccinterest(r,t) 
% Example ccinterest(0.02,5)
%
% peter.gruber@usi.ch, 2011-09-01

y = exp(r.*t);

end % of function


