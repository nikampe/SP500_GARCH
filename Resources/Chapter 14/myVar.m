function v = myVar(data)
% myVar works exactly like var
% INPUT    data ... Nx1 some data vector
% OUTPUT   v ...... 1x1 the variance

N=length(data);
data = data-myMean(data);
v=1/(N-1) * data.' * data;