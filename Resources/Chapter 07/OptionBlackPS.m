function  [c,p,d1,d2] = OptionBlackPG( S,X,T,r,sigma )
%BlackS   Calculates Black-Scholes european option prices.
%
%
%  Usage:      [c,p,d1,d2] = OptionBlackPS( S,X,T,r,sigma );
%
%  Inputs:     S      scalar or nx1 vector, possible current stock prices
%              X      scalar or nx1 vector, strike price
%              T      scalar, time to expiry of option
%              r      scalar, riskfree interest rate
%              sigma  scalar or nx1 vector, std in stock price evolution:
%                                  dS(t)=mu*S(t)dt+sigma*S(t)*dW(t)
%
%  Output:     c      nx1 vector, call option prices
%              p      nx1 vector, put option prices
%              d1     nx1 vector
%              d2     nx1 vector
%
%
%
%  Note:       If the underlying asset gives a dividend at the (continuous)
%              rate d, then supply S*exp(-d*T) instead of S. This holds for
%              both the B-S formula and the put-call parity.
%
%
%  Paul.Soderlind@unisg.ch, March 2002
%-----------------------------------------------------------------------

r=r(:);
d1 = ( log(S./X) + (r+1/2*sigma.^2).*T ) ./ (sigma.*sqrt(T));
d2 = d1 - sigma.*sqrt(T);

c  = S.*stdnCdf(d1) - X.*exp(-r.*T).*stdnCdf(d2);

p  = c + X.*exp(-r.*T) - S;            %put-call parity

%p  = X*exp(-r*T).*stdn_cdf(-d2) - S.*stdn_cdf(-d1);   %explicit put formula
%-----------------------------------------------------------------------

