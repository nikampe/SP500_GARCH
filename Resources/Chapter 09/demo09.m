%% code for section 09 of MATLAB script
f=@(x)x.^3;                        % Define true function
x=1;
truefprime=3*x.^2;   
              % Define true derivative 
h=10.^-(0:18);                     % Different values of h 
f_prime=( f(x+h)-f(x) )./h         % Calc all derivatives in one step
loglog(h,abs(truefprime-f_prime))  % Log/log plot of error 
                                   % as function of h 

%% Loss of precision theorem
x=1.23457;            % Define two similar numbers ... 
y=1.23456;            % with 6 digits of precision. 
format long 
-log10(1-y/x)         % Prediction of the number of digits lost. 
x-y                   % Result has only one digit of precision, 
                      % five lost. 
