function factN = myfactorial(n) 
% INPUT    n	 1x1 .... initial number 
% OUTPUT   factN 1x1 .... factorial of n 
% USAGE    myfactorial(n)
% peter.gruber@usi.ch, 2013-01-01

if n > 1
    
    disp('&&'); disp(n); 
    factN = n*myfactorial(n-1); 
    disp('&') ;
    disp(factN);
else
    factN = 1; 
end