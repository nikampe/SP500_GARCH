function [params, std_err, var] = garch_fit(data)
% This function produces and saves a sample partial autocorrelation plot
%
% INPUT data 1xn ... any column vector of time series
%       p int ... order of autoregressive part
%       q int ... order of moving-average part
% OUTPUT model 
%
% MATLAB Class - Group Assignment | Charalampos Elenidis, Niklas Kampe

% Number of Observations
N = length(data);

% Initialize GARCH Parameters
const = 0.0002;
alpha = 0.0679;
beta = 0.9300;
params_0 = [const, alpha, beta];

% Configuring Maximization Problem
A = [0 1 1]; 
b = 1;
Aeq = [];
Ceq = [];
lb = [0 0 0];
ub = [];
options = optimoptions('fmincon','Display','off');
[params, fval, exitflag, output, lambda, grid,hessian] = fmincon(@(params)garch_objective(params,data),params_0, A, b, Aeq, Ceq, lb, ub, [], options);
std_err = sqrt(diag(inv(hessian)));

% Initialize Vector of Sigmas
var = zeros(N,1);
% Set initial sigma
var(1)= sum(data.^2)/N;
% Loop over Number of Observations along Time Series
for i=2:N
    % Calculate current Sigma
    var(i)=params(1) + params(2)*data(i-1)^2+params(3)*var(i-1)^2;
end

end % of function