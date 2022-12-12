% num_diff.m
% Disentangle the analytical and numerical error contribution in numerical
% differentiation
% MATLAB course 2008
% peter.gruber@lu.unisi.ch

h=10.^-(0:20) 
x0 =2; 
f=@(x)x.^3; 
f0=f(x0);        % function value
f1=3*x0.^2;       % first derivative
f2=6*x0;         % second derivative

%% analytical contribution
for k=1:length(h) 
  err_analy(k) = f2/2*h(k)   % See eq. (9.5 LN)
end 

%% numerical error
f2=@(x)6*x;         % second derivative
for k=1:length(h) 
  q(k) = -log10(f1*h(k)/f0)
  err_num(k) = eps*10^q(k);   % numerical error approximation
end 

myfprime=(f(x0+h)-f(x0)) ./ h;  % true numerical error
myerr   = myfprime-f1;

%% make some plots
subplot(3,1,1)
loglog(h,err_analy)
title('Analytical error')
subplot(3,1,2)
loglog(h,err_num)
title('Numerical error')
subplot(3,1,3)
loglog(h,err_num+err_analy)
hold on
loglog(h,abs(myerr),'k.:')
title('Total error')
legend('theoretical','actual')

