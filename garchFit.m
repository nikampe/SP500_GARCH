function [params, std_err, var] = garchFit(data)
% Estimates the GARCH(1,1) in-sample parameters, std errors and the filtered 
% variance process
%
% INPUT data 1xn ... any column vector of time series
% OUTPUT params 3xn ... vector of estimated GARCH(1,1) parameters 
%        std_error ... vector of standard errors of estimated parameters 
%        var ... estimated filtered variance process 
%
% MATLAB Class - Group Assignment | Charalampos Elenidis, Niklas Kampe

% Number of observations
N = length(data);

% Initialize GARCH parameters to start optimization from
const_0 = 0.1;
alpha_0 = 0.3;
beta_0 = 0.5;
params_0 = [const_0, alpha_0, beta_0];

% Configuring maximization problem
A = [0 1 1]; 
b = 1;
Aeq = [];
Ceq = [];
lb = [0 0 0];
ub = [];
% Set optimization engine and options
options = optimoptions('fmincon','Display','off');
% Maximum-Likelihood Estimation (MLE)
[params, fval, exitflag, output, lambda, grid,hessian] = fmincon(@(params)garchObjective(params,data), params_0, A, b, Aeq, Ceq, lb, ub, [], options);
% Calculate standard errors from hessian matrix
std_err = sqrt(diag(inv(hessian)));

% Initialize vector of sigmas
var = zeros(N,1);
% Set initial sigma
var(1)= sum(data.^2)/N;
% Loop over full sample
for i=2:N
    % Calculate current volatility by means of GARCH(1,1)
    var(i) = params(1) + params(2)*data(i-1)^2 + params(3)*var(i-1)^2;
end
% Summary table of estimated GARCH(1,1) parameters
summary = table(transpose(params), std_err, 'VariableNames', ["Value", "Std Error"], 'RowNames', {'Const';'Alpha';'Beta'});

% Print summary of GARCH(1,1) estimation to console
disp("GARCH(1,1) - Model Fit")
disp("----------------------------------------------------------")
disp(summary)

end % of function