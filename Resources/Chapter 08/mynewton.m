% mynewton.m
% a demontration of newtons method for root finding
% peter.gruber@usi.ch, 2013-01-30

%% setup
fn=@(x)x.^4-x.^3-x.^2+5*x-2;   % function
f1=@(x)4*x.^3-3*x.^2-2*x +5;       % first derivative

xi=2.5;               % starting value

%% some setup for the output
myfigure=@(paper) figure('PaperPositionMode', 'manual','PaperUnits','centimeters', ...
    'PaperSize',paper,'PaperPosition', [0 0 paper],'Visible', 'on');
myprint=@(f,filename) print(f,'-dpdf',[filename '.pdf']);

g=myfigure([20 10])
fplot(fn,[-0.5 2.7],'b');
hold on
plot([-.7 2.7],[0 0],'k-');

%% the algorithm
while abs(fn(xi))>1E-2
    % calculate x_{i+1}
    xi1=xi-fn(xi)/f1(xi);
    % plot current tangent
    plot(xi,fn(xi),'ko');
    plot([xi1 xi],[0 fn(xi)],'k--');
    plot([xi1 xi1],[0 fn(xi1)],'k:');
    % update xi
    xi=xi1;
end
hold off
myprint(g,'newton')