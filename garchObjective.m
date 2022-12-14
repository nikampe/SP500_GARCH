function log_likelihood = garchObjective(params, data)
% Returns the log-likelihood value for a Gaussian distribution
%
% INPUT params 3x1 ... column vector of GARCH params (const, alpha, beta)
%       data nx1 ... column vector of returns series
% OUTPUT log_likelihood double ... log_likelihood statistic
%
% MATLAB Class - Group Assignment | Charalampos Elenidis, Niklas Kampe

% Number of observations
N = length(data);

% Initialize vector of sigmas
sigma = zeros(N,1);
% Set initial sigma
sigma(1)= sqrt(sum(data.^2)/N);

% Initialize log-likelihood function
log_likelihood = log(1/(sqrt(2*pi)*sigma(1)))-data(1)^2/(2*sigma(1)^2);

% Loop over full sample
for i=2:N
    % Calculate current volatility by means of GARCH(1,1)
    sigma(i)=sqrt(params(1) + params(2)*data(i-1)^2 + params(3)*sigma(i-1)^2);
    % Update Log-Likelihood Function
    log_likelihood = log_likelihood + ...
        log(1/(sqrt(2*pi)*sigma(i)))-data(i)^2/(2*sigma(i)^2);
end

% Return log-likelihood statistic (minimization to maximization)
log_likelihood = -log_likelihood;
   
end % of function