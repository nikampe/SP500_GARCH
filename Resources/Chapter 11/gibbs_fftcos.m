function gibbs_fftcos
% a presentation of the GIBBS phonomenon in FFT-COS transforms
% see also excellent animation
% http://en.wikipedia.org/wiki/Gibbs_phenomenon
% peter.gruber@lu.unisi.ch
% 2008-09-10

%% SETUP
Npoints = 1000;
x = linspace(-5,5,Npoints);
N = 50;                         % default value 25, try 100,500,5000

%% First we show a nice example, the standard normal distribution
sigma=1;
mu=0;
cf=@(t)exp(i*t*mu-0.5*t.^2*sigma^2);
true=normpdf(x,mu,sigma);
figure
MakePdfPlot2(cf,-5,5,x,true,N,1);

%% Next for the chisquared
a=-1;
b=100;
n=2;
cf=@(t)1 ./ (1-2*i*t).^(n/2);
x = linspace(-0.1,10,Npoints);
true = chi2pdf(x,n);
MakePdfPlot2(cf,a,b,x,true,N,2);
axis([-1 7 -0.05 0.5])

%% Now for uniform
a_uni=-2;
b_uni=2;
delta=zeros(1,N);delta(1)=1E-12;
cf=@(t) ( exp(i*(t+delta)*b_uni)-exp(i*(t+delta)*a_uni) ) ./ (i*(t+delta)*(b_uni-a_uni) );
x = linspace(-4,4,Npoints);
true=0.25*(abs(x)<2);
MakePdfPlot2(cf,-4,4,x,true,N,3);

%% POINT 
a_p=0;
cf=@(t)exp(i*t*a_p);
x = linspace(-4,4,Npoints);
true = zeros(Npoints,1);
%true(floor(length(x)/2))=60;
MakePdfPlot2(cf,-4,4,x,true,N,4);
axis([-5 5 -2 20])

%% Triangular [-1, 1]
delta=zeros(1,N);delta(1)=1E-12;
cf=@(t)( sin(t/2+delta)./(t/2+delta) ).^2;
x = linspace(-4,4,Npoints);
true = (1-abs(x)).*(abs(x)<1);
MakePdfPlot2(cf,-5,5,x,true,N,5);
axis([-2 2 -0.1 0.1])


end % of presentation function

%% ========== PRIVATE FUNCTIONS ==========
function MakePdfPlot2(cf,a,b,x,true,N,plotpos)
bma = b-a;
k = 0:N-1;
Fk = 2/bma * real( cf(k*pi/bma).*exp(-i*k*a*pi/bma)   );
Fk(1)=0.5*Fk(1);
for l=1:length(x)
    pdf(l)=sum(Fk.*cos (k*pi*(x(l)-a)/bma) );
end

subplot(2,5,plotpos)
plot(x,pdf);
title('FFTCOS pdf')
a=axis;
axis([min(x) max(x) a(3:4)])
subplot(2,5,plotpos+5)
plot(x,pdf(:)-true(:))
title('FFTCOS - true')
a=axis;
axis([min(x) max(x) a(3:4)])
end