function state = pacPlot(data, oTitle, file_name)
% This function produces and saves a sample partial autocorrelation plot
%
% INPUT data 1xn ... any column vector of time series
%       oTitle str ... text title of plot
%       file_name str ... folder location + file name to save plot
% OUTPUT state  bool .. succes/failure of operation
%
% MATLAB Class - Group Assignment | Charalampos Elenidis, Niklas Kampe
parcorr(data);
title(oTitle);
saveas(gcf, file_name);
state = true;

end % of function