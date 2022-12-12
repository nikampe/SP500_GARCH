% riemann_plot.m
% make a plot for the numeric integraion chapter of the matlab script
% peter.gruber@lu.unisi.ch
% 2008-12-04


%% setup
% function
f=@(x) 2*x.^3-1*x+0.5;

% step size ... good values are 0.25, 0.1, 0.05, 0.02, 0.01, 0.001
step=[0.5 0.2 0.05];

% integration bounds
lowerBnd=-0.5;
upperBnd=1.5;
Nstep=(upperBnd-lowerBnd)./step;

% prepare fugure
h=figure;
paper=[14 5];
set(h,'PaperPositionMode', 'manual','PaperUnits','centimeters', 'PaperSize',paper, ...
      'PaperPosition', [0 0 paper],'Visible', 'off');


%% perform integraion and produce sub-plots
for k=1:length(step)
    subplot(1,length(step),k);

    % x-values in the middle of each strip
    x=lowerBnd+step(k)/2 : step(k) : upperBnd-step(k)/2;

    % calcualte function values along steps
    y=f(x);
    
    % value of integral
    F=sum(y)*step(k);
    
    % make plot of steps
    bar(x,y,'EdgeColor',0.2*[1 1 1],'LineWidth',.2,...
            'FaceColor',0.9*[1 1 1],'BarWidth',1)
    hold on
    % now add a plot of the function
    x1=lowerBnd:0.01:upperBnd;
    y1=f(x1);
    plot(x1,y1,'k','LineWidth',1)
    plot(x,y,'b.','MarkerSize',10)

    % finally, calculate the numeric integral
    mytitle=sprintf('N=%2i; F=%5.3f',Nstep(k),F);
    title(mytitle)
    axis([lowerBnd upperBnd 0 6]);
end

%% produce the eps file
print(h,'-depsc','riemann.eps');
%print(h,'-dpdf','riemann.pdf');
