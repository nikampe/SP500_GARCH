function cdf = stdnCdf(a);
%Stdn_cdfPs    Calculates Pr(X<=a) for X which is N(0,1)
%
%  Usage:     cdf = Stdn_cdfPs(a)
%
%  Input:     a        nxk matrix
%  Output:    cdf      nxk matrix
%
%  Peter.gruber@unisg.ch, 2007-02-16
%  based on code by Paul.Soderlind@unisg.ch

cdf = 0.5 + 0.5*erf(a/sqrt(2));