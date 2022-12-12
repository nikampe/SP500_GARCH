%% code for section 8 of MATLAB script

%% Some MATLAB commands for polynomials
a=[1 2 3];           % Start with a vector 
p=poly(a)            % Produce polynomial (x-1)(x-2)(x-3). 
                     % Result is in form of coe?cients of x3, x2, x and 1. 
                     
%%
polyval(p,0)         % Evaluate polynomial at x = 0
polyval(p,1)         % Evaluate at root -> result is 0 

%%
x=0:0.1:4;           % polyval() is vector compatible
y=polyval(p,x);      % Use this for plots.
plot(x,y)

%%
r=[1 -2 1];          % Representation of x^2 - 2x + 1
roots(r)             % Solve the quadratic equation x^2-2x+1=0 
roots(p)             % Solve for the original polynomial, we get a

%% Taylor polynomials
p=[1/24 1/6 1/2 1 1];        % Taylor polynomial of exponential fn
                             % f(x)=1+x+x^2/2!+x^3/3!+... 
x=-3:0.1:3;                  % Some x-values 
plot(x,exp(x),'r');           % Plot original fn, 
hold on                      % hold on overlays approx. 
plot(x,polyval(p(4:end),x)); % The 1st order polynomial. 
plot(x,polyval(p(3:end),x)); % The 2nd order polynomial. 
plot(x,polyval(p(2:end),x)); % The 3rd order polynomial. 
plot(x,polyval(p,x));        % Full 4th order polynomial. 

