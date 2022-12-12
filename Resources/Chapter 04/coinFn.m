function tries=coinFn
% This function counts the number of tries until we have three "heads"
%
% INPUT    (no input)
%
% OUTPUT   tries    1x1    the number of tries needed
%
% Matlab class
% (c) 2005 peter.gruber@usi.ch


tries = 0;    % so far no tries
head  = 0;    % we did not yet launch a coin -> zero heads so far
   
while head<3                    % NOTE: Condition for loosing
    coin = round(rand(1,3));    % 3 coins, i.e. a vector with three zeros/ones
    head = sum(coin);           % number of heads
    tries = tries+1;
end
