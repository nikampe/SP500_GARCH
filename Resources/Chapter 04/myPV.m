function result = myPV(x, y, t, r)
% INPUT  x 1x1 .... initial payment
%        y 1x1 .... yearly payment
%        t 1x1 .... number of years
%        r 1x1 .... interest rate
%
% OUTPUT result ... present value of cash flow streams
% EXAMPLE myPV(100000,10000,20,0.05)

result = -x;                      % Initialize sum: value in year 0. 
for k = 1: t                      % We receive payments for the next 20 years 
  result = result + y/(1+r)^k;    % Running sum; every year we add to P V 
end 
