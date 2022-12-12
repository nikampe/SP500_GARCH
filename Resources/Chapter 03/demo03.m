%% Demo programs for chapter 03 of the script
% "Solving Economics and Finance Problems with MATLAB"
% peter.gruber@usi.ch, March 2021

%% Precision and floating point representation
1.23e-2             % Enter a small number in floating point notation.
7.56e4              %  A large number.
format shorte       % Output in floating point notation.
2140+1.567          % Note: exx means ×10^xx

format long
4.9+3.3
a=1+1E-16;
a-1

%% Type mismatch
format short
a=[1 2]; 
b=[1 2 3]; 
a+b

%% Working with matrices
load stocks				% A sample data set of simulated stock returns
size(stocks)
stocks(:,1)				% Returns of first stock
myPF=[1 4 7]			% My portfolio contains stocks number 1,4 and 7
stocks(:,myPF)			% Returns of stocks in my portfolio
myWt=[0.2 0.7 0.1].'    % My portfolio weights
stocks(:,myPF)*myWt		% Returns of my portfoli

%% Syntax of the colon operator
1:5 				% min : max produces a vector in steps of 1.
1:0.5:5 			% min:delta: max steps of delta=0.5.
5:-1:0 				% Note: delta can also be negative.
1.2:4.5 			% If the range max − min is not integer, 
					% the last fraction is discarded.

%% Arrays
retn=0.1*randn(252,3);                   % Produce some return data (252 trading days)
prices=cumprod(1+retn);                  % ... and prices.
Z1=cov(retn(1:63,:));                    % Covariance matrix for first quarter.
CX(:,:,1)=Z1;                            % Four variables Z1 to Z4 would be cumbersome.
Z2=cov(retn(64:126,:));
CX(:,:,2)=Z2;                            % Store everything in an array
CX(:,:,3)=cov(retn(127:189,:));
CX(:,:,4)=cov(retn(190:252,:));
CX(:,:,1)                                % Retrieve first covariance matrix
CX(1,2,:)                                % Time series of covariance(fist, second)
squeeze(CX(1,2,:))                       % Create a 4x1 vector

%% structures
obs.data=[6.0 5.5 4.0 5.5]	             % Numerical data (e.g. student grades) 
obs.info='Student grades'                % Text information about the data

% structures -- example: OLS.
% Produce fake data
X=rand(100,1);
Y=2*X+0.1+0.1*randn(100,1);
plot(X,Y,'.')
% Perform regression
result=regstats(Y,X)
result.beta
result.rsquare

%% Dotted operators
Y=[1 2; 3 4].';                          % Some matrix
Y*eye(2)                                 % Standard multiplication
Y.*eye(2)                                % Element-by-element multiplication
Y^2                                      % Matrix-wise square
Y.^2                                     % Element-by-element square

%% Example: verify that \sum q^k = 1/(1 - q) by summing up the first 21 elements.
q = 0.5; 
series = q.^(0:20);
sum(series)

%% Example: Relative quantities
height = [1.70 1.85 1.92 1.65 1.78]   % in meter
weight = [  88   92   89   54   70]   % in kg
BMI    = weight ./ height.^2

%% Functions
a=1:4									 % An input vector 
log(a)									 % The logarithm is applied to each element of a

%% Inline functions
sq=@(x)x^2 
sq(3.2) 
utilE=@(c,a)1-exp(-a*c) 
utilE(100,2) 
invlog=@(x)1/log(x) 
ssq=@(x,y,z)sq(x)+sq(y)+sq(z)

%% Example: matrix/vector-compatible functions
a=[1 3 5]					% An input vector
log(a)						% The logarithm is applied to each element of a
sq(a)						% Applying our function to a vector produces an error message.
sq2=@(x)x.^2				% Just add one dot to vectorize it.
sq2(a)						% Works.