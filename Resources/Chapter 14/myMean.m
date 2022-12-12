function m = myMean(data)
% myMean works exactly like mean
% INPUT    data ... Nx1 some data vector
% OUTPUT   m ...... 1x1 the mean

N=length(data);
m=1/N * ones(1,N)*data;