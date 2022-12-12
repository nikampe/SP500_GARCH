% coinDist.m
% This excellent piece of software produces 
% the distribution of number of tries until you hit
% three "heads" with three coins
% (c) peter.gruber@usi.ch, 2013-02-26

NSim = 10000;

for k=1:NSim
    realization(k)=coinFn;
end

hist(realization,1:100);