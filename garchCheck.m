function summary = garchCheck(params, data, p, q)
% Checks estimated GARCH(1,1) parameters against the native function
%
% INPUT params 3x1 ... column vector of GARCH params (const, alpha, beta)
%       data nx1 ... column vector of returns series
%       p int ... order of autoregressive part
%       q int ... order of moving-average part
% OUTPUT summary table ... summary of difference statisitcs
%
% MATLAB Class - Group Assignment | Charalampos Elenidis, Niklas Kampe

% Catch error if p,q not equal to one
if p~=1 || q~=1
    error("Orders p and q must be 1.")
end

% Set up GARCH(1,1) native toolbox function
model = garch('GARCHLags', p, 'ARCHLags', q);
% Estimate GARCH(1,1) parameters by native toolbox function
model_fit = estimate(model, data, 'Display', 'off');
% Extract estimated GARCH(1,1) parameters by native toolbox function
params_native = [model_fit.Constant; cell2mat(model_fit.ARCH); cell2mat(model_fit.GARCH)];
% Calculate difference to custom GARCH(1,1) estimation by means of MLE
params_diff = transpose(params) - params_native;

% Summary table of native toolboox vs. custom GARCH(1,1) results
summary = table(transpose(params), params_native, params_diff, 'VariableNames', ["Custom Function", "Native Function", "Difference"], 'RowNames', {'Const';'Alpha';'Beta'});

% Print summary of GARCH(1,1) estimation to console
disp("GARCH(1,1) - Model Fit - Check against Native Function")
disp("----------------------------------------------------------")
disp(summary)

end % of function