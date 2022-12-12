% fn_properties.m
% A short demo of some properties of some functions
% MATLAB course 2008
% peter.gruber@lu.unisi.ch

f=@(x)x.^2      % Vector-compatible function
fp=@(x)2*x      % first derivative
subplot(2,1,1)
fplot(f,[-2 2]) % Plot  function
subplot(2,1,2)
fplot(fp,[-2 2]) % Plot derivative
grid

%%
g=@(x)exp(x)    % function
gp=@(x)exp(x)   % derivative
subplot(2,1,1)
fplot(g,[-2 2]) % Plot  function
subplot(2,1,2)
fplot(gp,[-2 2]) % Plot derivative

%%
h=@(x)log(x);
hp=@(x)1./x;
subplot(2,1,1)
fplot(h,[0 2]) % Plot  function
subplot(2,1,2)
fplot(hp,[0 2]) % Plot derivative



