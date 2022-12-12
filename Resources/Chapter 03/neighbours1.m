function nb = neighbours1(x)
% This function produces the neigbours of a number
% Version with output in structure
%
% INPUT		x  1x1   ... a scalar
% OUTPUT    nb struct
%               nb.p ... predecessor
%               nb.s ... successor
%
% MATLAB class, peter.gruber@usi.ch

nb.p=x-1;
nb.s=x+1;

end % of function