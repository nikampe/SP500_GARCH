function d = definite (matrix)
% Checks whether a matrix is positive / negative (semidefinite) or indefinite.
%
% INPUT     matrix   nxn      the test matrix
%
% OUTPUT    d        -1/0/1  -1 for negative defnite
%                             0 for indefinite
%                             1 for positive definite
%
% MatLab course 2007, peter.gruber@unisg.ch

% Check all the eigenvalues. If all are positive/negative, then matrix is
% positive/negative definite

e = eigs(matrix);

if e >= 0 
    d = 1;
elseif e <= 0
    d= -1;
else
    d=0;
end


