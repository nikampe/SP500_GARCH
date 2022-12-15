% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% main.m
%
% A program to estimate GARCH(1,1) models (parameters and volatility process)
% through MLE and to calculate the % 95% confidence intervals for 30d-ahead 
% predictions on S&P500 daily returns
%
% University of St. Gallen | MATLAB Class - Group Assignment
% Authors: Charalampos Elenidis, Niklas Leander Kampe
% Supervisor: Prof. Dr. Peter Gruber
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

% Import data
data = readtable('data.csv');

% Date vector
dates = data{:,"Date"};
% Price Vvctor from closing prices
prices = data{:,"Close"};
% Number of observations
N = length(prices);
% Log-, avsolute and squared return vector
returns = log(prices(2:N) ./ prices(1:N-1));
returns_absolute = abs(returns);
returns_squared = returns.^2;

% Plot of price series
plotTs(dates, prices, 'Time (Year)','Price','Price','S&P 500 Price Series (2007-2022)','Figures/Plot_Prices.png');
% % Plot of return series
plotTs(dates(2:end), returns, 'Time (Year)','Return','Return','S&P 500 Return Series (2007-2022)','Figures/Plot_Returns.png');
% Plot sample (partial) autocorrelations of returns
plotAcf(returns, "Returns", 'Figures/Plot_Autocorrelations_Returns.png');
plotPacf(returns, "Returns", 'Figures/Plot_Partial_Autocorrelations_Returns.png');
plotAcf(returns_absolute, "Absolute Returns", 'Figures/Plot_Autocorrelations_Returns_Absolute.png');
plotPacf(returns_absolute, "Absolute Returns", 'Figures/Plot_Partial_Autocorrelations_Returns_Absolute.png');
plotAcf(returns_squared, "Squared Returns", 'Figures/Plot_Autocorrelations_Returns_Squared.png');
plotPacf(returns_squared, "Squared Returns", 'Figures/Plot_Partial_Autocorrelations_Returns_Squared.png');

% GARCH(1,1) - Setup
p = 1;
q = 1;
% GARCH(1,1) - Model fit
[params, std_err, var] = garchFit(returns);
% GARCH(1,1) - Model fit - Plot of filtered variance process
plotTs(dates(2:N), var, 'Time (Year)','Variance','Filtered Variance','Filtered Variance (2007-2022) - In-Sample Fit','Figures/Plot_Filtered_Variance_IS.png');
% GARCH(1,1) - Model fit - Comparison with native toolbox Function
garchCheck(params, returns, p, q);

% 95% Confidence intervals for 30d prediction
n_pred = 30;
ci = NaN(N-n_pred,2);
sigma_pred = NaN(N-n_pred,1);
% Generate matrix of Gaussian RV realizations for each 30d period
rng(8317462);
epsilon = normrnd(0, 1,[N-n_pred, n_pred]);
% Loop over all 30d periods
for j=1:N-n_pred
    % Initiate vectors for volaitlity & return Prediction
    sigma = zeros(n_pred,1);
    ret = zeros(n_pred,1);
    % Set initial volatility (predicted by in-sample fit)
    sigma(1) = sqrt(var(j));
    % Set initial returns (shfited by one since lagged by one against Var)
    ret(1) = returns(j+1);
    % Loop over all days within 30d period
    for k=2:n_pred
        % Calculate volatility and return prediction by means of GARCH(1,1)
        sigma(k) = sqrt(params(1) + params(2)*(ret(k-1)^2) + params(3)*sigma(k-1)^2);
        ret(k) = sigma(k)*epsilon(j,k);
    end
    % Append 30d-ahead prediction to volatility prediction vector
    sigma_pred(j) = sigma(n_pred);
    % Generate and append upper and lower confidence bound
    ci(j,1) = mean(ret) - 1.96.*sigma_pred(j);
    ci(j,2) = mean(ret) + 1.96.*sigma_pred(j);
    clear sigma;
    clear ret;
end

% Number of violations of 30-ahead realizations
violations = 0;
% Loop over all 
for g=1:N-n_pred
    ci_lower = ci(g,1);
    ci_upper = ci(g,2);
    % Update number of violations if below (above) the lower (upper) bound
    if returns(g+n_pred-1)<ci_lower || returns(g+n_pred-1)>ci_upper
        violations = violations + 1;
    end
end
% Summary output of violations statistics
disp("95% Confidence Interval Violations")
disp("----------------------------------------------------------")
disp("Number of CI Violations: " + violations)
disp("Probability CI Violations: " + round((violations/(N-n_pred))*100,2) + "%")

% Plot of 95% Lower & Upper Bound vs. Return Realizations
figure();
plot(dates(n_pred+1:end), ci(:,1:2),"Color", "green"); hold on;
plot(dates(n_pred+1:end), returns(n_pred:end),"Color", "red"); 
legend("Return Realization","95% Upper & Lower Bound");
xlabel("Time (Year)");
ylabel("Return");
title("Return Realizations vs. 95% Upper & Lower Bound of 30d Prediction");
saveas(gcf, "Figures/Plot_Confidence_Interval_Violations.png");

% End of main.m