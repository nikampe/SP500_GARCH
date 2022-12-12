function definfo(matrix)
% Prints information about the definiteness of a matrix.
% 
% INPUT     matrix   nxn      the test matrix
% OUTPUT    (no output)
% USAGE     definfo(mx)
%
% USES      definite.m
%
% MatLab course 2007, peter.gruber@unisg.ch

switch definite(matrix)
  case -1 
    disp('Negative (semi)definite'); 
  case 0 
    disp('Indefinite'); 
  case 1 
    disp('Positive (semi)definite'); 
end 
