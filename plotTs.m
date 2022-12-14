function state = plotTs(x, y, x_label, y_label, oLegend, oTitle, file_name)
% This function produces and saves a time series plot
%
% INPUT x 1xn ... any column vector on x-axis
%       y 1xn ... any column vector on y-axis
%       x_label str ... text label of x-axis
%       y_label str ... text label of y-axis
%       oLegend str ... text label plotted series
%       oTitle str ... text title of plot
%       file_name str ... folder location + file name to save plot
% OUTPUT state  bool .. succes/failure of operation
%
% MATLAB Class - Group Assignment | Charalampos Elenidis, Niklas Kampe

% Create time series plot
plot(x, y);
xlabel(x_label);
ylabel(y_label);
legend(oLegend);
title(oTitle);
grid on;
% Save plot as png in dedicated folder
saveas(gcf, file_name);

% Return
state = true;

end % of function