function state = plotAcf(data, oTitle, file_name)
% Creates and saves a plot of Sample Autocorrelations 
%
% INPUT data 1xn ... any column vector of time series
%       oTitle str ... text title of plot
%       file_name str ... folder location + file name to save plot
% OUTPUT state  bool .. succes/failure of operation
%
% MATLAB Class - Group Assignment | Charalampos Elenidis, Niklas Kampe

% Create sample autocorrelation plot
autocorr(data);
title(oTitle);
% Save plot as png in dedicated folder
saveas(gcf, file_name);

% Return
state = true;

end % of function