function log_likelihood = garch_objective(params, data)
% This function produces and saves a sample partial autocorrelation plot
%
% INPUT params 3x1 ... column vector of GARCH params (const, alpha, beta)
%       data nx1 ... column vector of returns series
% OUTPUT log_likelihood double ... log_likelihood statistics (to be max)
%
% MATLAB Class - Group Assignment | Charalampos Elenidis, Niklas Kampe

% Number of Observations
N = length(data);

% Initialize Vector of Sigmas
sigma = zeros(N,1);
% Set initial sigma
sigma(1)= sqrt(sum(data.^2)/N);

% Initialize Log-Likelihood Functioon
log_likelihood = log(1/(sqrt(2*pi)*sigma(1)))-data(1)^2/(2*sigma(1)^2);

% Loop over Number of Observations along Time Series
for i=2:N
    % Calculate current Sigma
    sigma(i)=sqrt(params(1) + params(2)*data(i-1)^2+params(3)*sigma(i-1)^2);
    % Update Log-Likelihood Function
    log_likelihood = log_likelihood + ...
        log(1/(sqrt(2*pi)*sigma(i)))-data(i)^2/(2*sigma(i)^2);
end

% Minimization to Maximization
log_likelihood=-log_likelihood;
   
end