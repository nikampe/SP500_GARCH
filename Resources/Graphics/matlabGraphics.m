% matlab Graphics
% An interactive introduction to graphics with MATLAB
% peter.gruber@usi.ch

%% setup
load dataMATLABgraphics

%% cross-sectional data, e.g. options
plot(option.call)                   % no x-values given, i.e. "contract #1, #2, ..."
plot(option.strike,option.call)     % x and y values
xlabel('strike')                    % label for x and y values
ylabel('price')
legend('call price')
title('A simulated option chain')
grid on

%% formatting plot lines
plot(option.strike,option.call,'--dr')    % Line / marker / color
plot(option.strike,option.call,'ko')     % (no line) / marker / color

% now try a green dotted line with square symbols

%% RGB color system and more options
plot(option.strike,option.call,'LineWidth',2,'Color',[.4 1 .4])     
% now try to make a plot in the following colors
% - light grey
% - dark grey
% - dark blue

plot(option.strike,option.call,'o','MarkerSize',20,...
    'MarkerEdgeColor',.5*[.4 1 .4],'MarkerFaceColor',[.4 1 .4])     
% now try grey dots without border


% how do marker sizes scale?
plot(1,1,'s','MarkerSize',10);
hold on
plot(1,1.5,'s','MarkerSize',100);
axis([0.5 1.5 0.5 2])

axis([-5 5 -5 5])

% NOTE: we will revisit this data set

%% time series plots
plot(myStock(:,1))      % no x-values given
plot(myStock)           % still no x-values, multiple data columns
plot(myStock.')         % complete mess; data must be in rows

%% multiple lines in one plot
plot(myStock(:,1),'k')       % stock 1
hold on
plot(myStock(:,2),'--k')     % stock 2
plot(myStock(:,3),':k')      % stock 3
hold off

% now try to change this plot so that all stocks start at 100
% i.e. rebase the series

%% automate multiple plots using a for loop
myStyle={'k','--k',':k'};
for u=1:3
    plot(myStock(:,1),myStyle{u});
    hold on                         % no problem to use multiple hold on
end

%% better time series plots
plot(myDate, myStock(:,1))      % give unix dates as x-values
datetick('x',1)                 % date information on x-axis
axis([myDate(1) myDate(end) 0 120])

datetick('x',29)                 % better date formatting
axis([myDate(1) myDate(end) 0 120])
                                % need to re-run axis

% find out how to format the dates
% - as 2014-01-01 (and so on)
% - as 01.01.2014 


%% log scale
plot(myDate,myStock(:,1)); datetick('x',10)
semilogy(myDate,myStock(:,1)); datetick('x',10)

%% working with returns
retn=log(myStock(2:end,1))-log(myStock(1:end-1,1))
whos SPX*                                         % 1 fewer returns than closes!
plot(myDate(2:end,1),retn); datetick('x',10)
hist(retn);
% change the hist so that it becomes more meaningful
myvar=retn.^2;                                % squared returns
plot(myDate(2:end,1),myvar); datetick('x',10)
hist(myvar)

%% autocorrelogram
autocorr(retn)

%% 2 plots in 1
subplot(2,1,1)              % number of rows, no of columns, number of plot
autocorr(retn)
subplot(2,1,2)
autocorr(myvar)
% change this plot to incude 66 lags (1 quarter)

%% Scenarios
% a simple Monte Carlo simulation
T=100; N=1000;                  % T periods, N simulations
sigma=0.05;
logRet=sigma*randn(T,N);
simPath=exp(cumsum(logRet));
plot(simPath)
plot(simPath(:,1:10))
PlotQuantileTS(simPath.',10);

% find out how to show the following quantiles: 
% [0.025 0.1 0.25] and the median



%% GDP in some euro countries
startDate='2013-10-01';
endDate  ='2013-10-01';

[calDate GDPdeu]=fred2read('DEUGDPNQDSMEI',startDate,endDate);
[calDate GDPfra]=fred2read('FRAGDPNQDSMEI',startDate,endDate);
[calDate GDPita]=fred2read('ITAGDPNQDSMEI',startDate,endDate);
[calDate GDPesp]=fred2read('ESPGDPNQDSMEI',startDate,endDate);
plot([GDPdeu GDPfra GDPita GDPesp])
bar([GDPdeu GDPfra GDPita GDPesp])
set(gca,'XTickLabel',{'DE','FR','IT','ES'})

%% more efficient: define vectors of data and labels
allGDP=[GDPdeu GDPfra GDPita GDPesp];
allGDPlabel={'DE','FR','IT','ES'};

pie(allGDP)
pie(allGDP,allGDPlabel)
pie(allGDP,[1 0 0 0],allGDPlabel)

%% better design
h=pie(allGDP,[1 0 0 0],allGDPlabel);
hp = findobj(h, 'Type', 'patch');
for k=1:4
    set(hp(k),'FaceColor',(k)/5*[.6 .8 1],'EdgeColor','none');
end

%% GDP in the whole Eurozone
clear allGDP*
allGDPcc     = {'DEU','FRA','ITA','ESP'};    % cc = countryCode
allGDPlabel  = {'DE','FR','IT','ES'};

for u=1:length(allGDPcc)
    [calDate allGDP(:,u)]=fred2read([allGDPcc{u} 'GDPNQDSMEI'],startDate,endDate);
end

h=pie(allGDP,allGDPlabel);
hp = findobj(h, 'Type', 'patch');
for k=1:length(allGDPcc)
    set(hp(k),'FaceColor',(k)/(length(allGDPcc)+1)*[.6 .8 1],'EdgeColor','none');
end

% now add at least a few other countries of the Eurozone

% how can we add the percentages of the GDP to the label?
% see sprintf(format,number)


%% more than 2 dimensions
% example: option price, strike, volume
plot(option.strike,option.call)
hold on
plot(option.strike,option.callvol)
% can we do better?

%% Scatter plot
scatter(option.strike,option.call,option.callvol,'go','filled')

% even more dimesions: shape and color
hold on
scatter(option.strike,option.put,option.putvol,'rs','filled')

%% even one more dimension
% example: option price, strike, volume and time to maturity
scatter(option2.strike,option2.call,option2.callvol/10,option2.T,'o','filled')
colorbar

%% Saving a figure to a file

% (1) fix the *print size* of your figure
paper=[20 12];              % i.e. 20cm wide, 12cm tall

% (2) create a new, empty figure
h=figure('PaperPositionMode', 'manual','PaperUnits','centimeters', ...
    'PaperSize',paper,'PaperPosition', [0 0 paper],'Visible', 'on');

% (3) now make the plot
scatter(option2.strike,option2.call,option2.callvol/10,option2.T,'o','filled')
colorbar

% (4) save to file
print(h,'-dpdf','myfirstplot.pdf');

% now find out how to write a JPEG, a TIFF (with 300dpi) and EPS
% also check PNG files, which are very compact


%% ========== EXERCISES ==========

%% *** multitple pie charts
%  illustrate the growth of the eurozone economy

startDate={'2000-01-01','2005-01-01','2013-10-01'};
endDate  =startDate;

% now get the data for each country for each year
% make pie chart with subplots using
% myPlot(k)=subplot(1,3,k)  etc

% at the end, scale the subplots using this command
% set(myPlot(k),'Xlim',[-1.2 1.2]/scaleFactor(k))
% where 0<=scaleFactor(k)<=1




