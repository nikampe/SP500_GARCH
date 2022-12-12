% Import data
data = readtable('data.csv');

% Price Vector from Closing Prices
prices = data{:,"Close"};
% Number of Observations
n_obs = length(prices);
% Return Vectors
returns = log(prices(2:n_obs) ./ prices(1:n_obs-1));
returns_absolute = abs(returns);
returns_squared = returns .* returns;

% % Plot of Price Series
% dates_prices = data{:,"Date"};
% tsPlot(dates_prices, prices, 'Time (Year)','Price','Price','S&P 500 Price Series (2007-2022)','Figures/Plot_Prices.png');
% % % Plot of Return Series
% dates_returns = data{:,"Date"}(2:n_obs);
% tsPlot(dates_returns, returns, 'Time (Year)','Return','Return','S&P 500 Return Series (2007-2022)','Figures/Plot_Returns.png');
% % Plot Sample (Partial) Autocorrelation of Returns
% acPlot(returns, "Returns", 'Figures/Plot_Autocorrelations_Returns.png');
% pacPlot(returns, "Returns", 'Figures/Plot_Partial_Autocorrelations_Returns.png');
% acPlot(returns_absolute, "Absolute Returns", 'Figures/Plot_Autocorrelations_Returns_Absolute.png');
% pacPlot(returns_absolute, "Absolute Returns", 'Figures/Plot_Partial_Autocorrelations_Returns_Absolute.png');
% acPlot(returns_squared, "Squared Returns", 'Figures/Plot_Autocorrelations_Returns_Squared.png');
% pacPlot(returns_squared, "Squared Returns", 'Figures/Plot_Partial_Autocorrelations_Returns_Squared.png');

% GARCH(1,1) - Setup
p = 1;
q = 1;
% GARCH(1,1) - Model Fit
[params, std_err, var] = garch_fit(returns);
const = params_fit(1);
alpha = params_fit(2);
beta = params_fit(3);
err = std_err;
disp("GARCH(1,1) - Model Fit")
disp("----------------------------------------------------------")
disp("Const: " + const + " (" + err(1) + ")")
disp("Alpha: " + alpha + " (" + err(2) + ")")
disp("Beta: " + beta + " (" + err(3) + ")")
% GARCH(1,1) - Model Fit - Plot of Filtered Variance Process
dates_var = data{:,"Date"}(2:n_obs);
% tsPlot(dates_var, var, 'Time (Year)','Variance','Filtered Variance','Filtered Variance (2007-2022) - In-Sample Fit','Figures/Plot_Filtered_Variance_IS.png');
% GARCH(1,1) - Model Fit - Comparison with Built-In Function
model = garch('GARCHLags',p,'ARCHLags',q);
model_fit = estimate(model, returns);
disp("GARCH(1,1) - Model Fit - Accuracy to Native Function")
disp("----------------------------------------------------------")
disp("Const: " + round((const-model_fit.Constant), 6))
disp("Alpha: " + round((alpha-cell2mat(model_fit.ARCH)), 6))
disp("Beta: " + round((beta-cell2mat(model_fit.GARCH)), 6))
