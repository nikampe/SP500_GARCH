% myinterpolation.m
% peter.gruber@usi.ch, 2013-01-31
% produce a plot with different piecewise interpolation schemes

%% setup
% some data points from a yield curve
data=csvread('interest_20040202.csv',1,0);

% pretend that we have only very few data points
data=data([2 7 9 13 20 34],:);
mat=data(:,1);
rate=data(:,2);

%% some setup for the output
myfigure=@(paper) figure('PaperPositionMode', 'manual','PaperUnits','centimeters', ...
    'PaperSize',paper,'PaperPosition', [0 0 paper],'Visible', 'on');
myprint=@(f,filename) print(f,'-dpdf',[filename '.pdf']);

%% make a comparison
h=myfigure([20 12]);
x = 0:30:2000;

subplot(2,3,1);
y = interp1(mat,rate,x,'nearest','extrap');
plot(x,y,'k')
hold on
plot(mat,rate,'ko');
axis([0 2000 1 4])
title('Nearest neighbour');

subplot(2,3,4);
plot(x(2:end),diff(y),'k')
%axis([0 2000 1 4])

subplot(2,3,2);
y = interp1(mat,rate,x,'linear','extrap');
plot(x,y,'k')
hold on
plot(mat,rate,'ko');
axis([0 2000 1 4])
title('Linear');

subplot(2,3,5);
plot(x(2:end),diff(y),'k')
%axis([0 2000 1 4])

subplot(2,3,3);
y = interp1(mat,rate,x,'cubic','extrap');
plot(x,y,'k')
hold on
plot(mat,rate,'ko');
axis([0 2000 1 4])
title('Cubic splines');

subplot(2,3,6);
plot(x(2:end),diff(y),'k')
%axis([0 2000 1 4])

myprint(h,'interpolation')

%% some problems with interpolation
% The following data is variance swap data for August 31, 1998
% First column: maturity in month, second column: variance swap rate in
% percent per year
data=csvread('varianceSwaps_19980831.csv',1,0);
figure
plot(data(:,1),data(:,2),'bo')
hold on

% Imagine, we are interested in variance swaps up to 1 year
mat=data(1:5,1);
matInt=1:12;
rate=data(1:5,2);
rateInt=interp1(mat,rate,matInt,'spline');   % spline interpolation
plot(matInt,rateInt,'b');
rateInt=interp1(mat,rate,matInt,'pchip');    % cubic interpolation
plot(matInt,rateInt,'b--');

% Is it a good idea to include the 24 month observation, even if we are
% only interested in maturities up to 12 months?
mat=data(:,1);
matInt=1:24;
rate=data(:,2);
rateInt=interp1(mat,rate,matInt,'spline');
plot(matInt,rateInt,'r');
rateInt=interp1(mat,rate,matInt,'pchip');
plot(matInt,rateInt,'r--');
legend('Data','Spline12','Cubic12','Spline24','Cubic24')


