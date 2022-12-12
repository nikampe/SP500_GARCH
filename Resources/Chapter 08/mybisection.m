% mybisection.m
% a demontration of the bisection method for inverting a function
% peter.gruber@usi.ch, 2013-01-30

%% setup
fn=@(x)-0.02*x.^4+0.15*x.^3-0.12*x+0.5;
% uncomment the line below to check for decreasing functions
% fn=@(x)6.15-(-0.02*x.^4+0.15*x.^3-0.12*x+0.5);
xL=.2; xR=4.9;                  % starting value
nIter=1;                        % number of iterations
x0=2.9;                         % true x value
y0=fn(x0);                     % true y value (to be inverted)

%% some setup for the output
myfigure=@(paper) figure('PaperPositionMode', 'manual','PaperUnits','centimeters', ...
    'PaperSize',paper,'PaperPosition', [0 0 paper],'Visible', 'on');
myprint=@(f,filename) print(f,'-dpdf',[filename '.pdf']);

g=myfigure([12  8])
fplot(fn,[0 5],'b');
hold on
%plot([x0 x0],[0  y0],'k');
plot([0  x0],[y0 y0],'k');


%% the algorithm
while (xR-xL)>.05
    yL=fn(xL);  yR=fn(xR);
    plot([xL   xL],[.5-nIter/4 yL],'r');
    plot([-0.7 xL],[yL      yL],'r');
    plot([xR   xR],[.5-nIter/4 yR],'r');
    plot([-0.7 xR],[yR      yR],'r');
    plot([xL xR],[.6-nIter/4 .6-nIter/4],'r');
        
    % calculate new interval
    xM=1/2*(xL+xR);
    yM=fn(xM);
    if y0>min(yL,yM) & y0<max(yL,yM)     % y is in the LEFT interval
        xR=xM;
    else       % choose right interval
        xL=xM;
    end
    plot([xM   xM],[.6-nIter/4 yM],'r--');
    plot([-0.7 xM],[yM      yM],'r--');
    axis([0 5 -1.5 6.5])
    myprint(g,['bisection' num2str(nIter)])
    nIter=nIter+1;
end
hold off
myprint(g,'bisection')