function [f,g] = myfun(x) 
% myfun is a simple function to demonstate optimization with gradients
% See MATLAB script, section 10
% INPUT   x ... 2x1 input argument
% OUTPUT  f ... 1x1 function value
%         g ... 2x1 gradient vector
%
% peter.gruber@usi.ch, 2011-10-02

f = x(1)^2 + x(2)^2;	%Our function 
g = [2*x(1); 2*x(2)];	% Its gradient (note: gradient is a column vector)
end