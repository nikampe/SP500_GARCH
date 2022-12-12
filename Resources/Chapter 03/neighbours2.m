function [predec,success] = neighbours2(x)
% This function produces the neigbours of a number
% Version with 2 output variables
%
% INPUT x 1x1 ... any scalar
% OUTPUT predec  1x1 .. the precedessor
%        success 1x1 .. the successor
%
% MATLAB class, peter.gruber@usi.ch

predec = x-1;
success= x+1;

end % of function