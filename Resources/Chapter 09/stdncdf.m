function y= stdncdf(x)
% This function calculates the values of N(x) by means of the erf function
% which is used for the calculation of N(d1) and N(d2) in the Black Scholes
% formula
% INPUT:    x    1x1 .. variable 
% OUTPUT:   N(x) 1x1 .. cdf value of input x 
% livia.notter@student.unisg.ch 4th October 2011

y=1/2+1/2*erf(x/sqrt(2));

end
