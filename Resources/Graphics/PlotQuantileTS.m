function PlotQuantileTS(X,Q,col,xLabel,xBin)
% quantileplot.m
% Produces a quantile plot of a time series, inspired by the 
% Bank of England's inflation report
%
% INPUT  X ..... NxT       series of N observations for T dates
%        Q* .... 1x1       numer of quantiles to be shown (should be even)
%                          e.g. use Q=10 for deciles
%           .... 1xK       inner boundaries of quantiles, e.g.
%                          [0.25 0.5 0.75] or [0.1 0.5 0.9]
%        col* .. (Q/2)x3   color specifications; last color is line color
%                          for median
%        xLabel* 1xT       Numeric labels for the x axis
%        xBin*.. 1x1       Number of dates that should be binned together
%                          e.g. use xBin=5 to bin daily data to weeks
%                          * optional arguments
%        
% OUTPUT ...... a graph
%
% peter.gruber@usi.ch, 2012-07-22

if length(Q)==1
    Xqua=quantile(X,1/Q:1/Q:(1-1/Q));
else
    Xqua=quantile(X,Q);
    Q=length(Q)+1;
end

if nargin<2 || isempty(Q)
    if nargin==3
        Q=2*size(col,1);
    else
        Q=10;
    end
end

if nargin<3 || isempty(col)
    col=.5+linspace(.375,0,Q/2-1).'*[1 1 1];
    col=[col; 0 0 0];
end

[N,T]=size(X);
if nargin<4 || isempty(xLabel)
	xLabel=1:T;
end

% Binning in time (optional)
if nargin>4 && xBin>1
    xBin=floor(xBin);
    % how many rows are missing so that xBin is a divisor of T?
    excessCols=mod(T,xBin);
    if excessCols>0
        X(:,end-excessCols+1:end)=[];
        T=T-excessCols;
    end
    X=reshape(X,N*xBin,T/xBin);
    %X=reshape(X',T/xBin,N*xBin)';
    xLabel=xLabel(ceil(xBin/2):xBin:T);
    [N,T]=size(X);
end



    
for q=1:(Q/2-1)
    fill([xLabel xLabel(end:-1:1)],[Xqua(q,1:T) Xqua(Q-q,T:-1:1)],col(q,:),'EdgeColor','none');
    hold on
end
plot(xLabel,Xqua(Q/2,1:T),'Color',col(Q/2,:),'LineWidth',.2)

end% of function
