%% demo06.m ==================================
% demo programs for chapter 06 of the MATLAB script
% peter.gruber@usi.ch, 2013-10-10

%% Systems of equations
A=[2 3 4; 2 -1 2; 3 4 5]
b=[23 8 30].'              % Column vector
x=inv(A)*b                 % One possible solution
x=A\b                      % Alternative with Gaussian elimination
A*x                        % Verify result
help mldivide              % Find out more about the matrix division using \
A=[2 3 4; 2 3 4; 3 4 5]
x=inv(A)*b                 % A has two linear dependent row vectors -> error.
rank(A)                    % A does not have full rank.


%% PC-Lab: From equation to program -- OLS step-by-step

%%Data preparation
load attend.txt            % Load data.
[n,k]=size(attend)         % Number of rows, number of columns.
type attend.des            % Check the data description and decide which part of the data to use.
Y=attend(:,2);             % New explained variable Y ...
X=[ ones(n,1) attend(:,1) attend(:,3) attend(:,7) ]   % ... and explanatory variable X
X=[ ones(n,1) attend(:,[1 3 7]) ]   % Shorter, equivalent version
[n,k]=size(Y)              % Verify dimensions of the sample that we are going to use.
[n,k]=size(X)

%% Verifying the OLS assumptions
% See appendix C of the script
% MLR.1 can be verified by inspecting the regression equation. 
% MLR.2 and MLR.3 cannot be verified. 
rank(X)                    % Verify MLR.4 by calculating the rank of X

%% OLS estimate
rank(X.'*X)                % Has same  rank by construction: rk(A)=rk(A'A)
b=inv(X.'*X)*X.'*Y         % The regression coefficients (we write b for beta).
u=X*b-Y                    % The residuals (we write u for epsilon.)
mean(u)                    % Not a verification of {\bf MLR.2}. 
                           % sum(u)=0 by construction of the estimator.

%% Error terms and R^2
SST=(Y-mean(Y)).'*(Y-mean(Y)) % This is equivalent to SST = sum ( (y_i -y_hat)^2 )
SSR=u.'*u                  % This is equivalent to SSR = sum ( u_i^2 )
R2=1-SSR/SST               % r squared
si2hat=u.'*u/(n-k-1)       % Estimate sigmahat^2
sihat=sqrt(si2hat)         % And calculate sigmahat

%% Standard errors and t-test
Xinv=inv(X.'*X)            % First step towards standard errors.
dXi=diag(Xinv)             % New command diag(), self-explaining.
sdXi=sqrt(dXi)             % Vector of $\sqrt{((X.'X)^{-1})_{jj}}$
seb=sihat*sdXi             % $se(\hat\beta_j))=\sigma \sqrt{((X.'X)^{-1})_{jj}}$
tval=tinv(.95,n-k-1)       % Value of the t-statistic for 90\% confidence interval.
                           % Admittedly, tinv() is used from the statistics toolbox.
bmin=b-tval*seb            % Lower bound.
bmax=b+tval*seb            % Upper bound.

[b seb]                    % Output beta and its standard erros.
[bmin b bmax]              % Output confidence interval and point estimate of beta
tstat=b./seb               % t-statistic. Note the dotted (.) division operator.
pval=2*tcdf(-abs(tstat),n-k-1)
[b seb tstat pval]         % The p-values and a typical output.


%% Spectral theory

%% First step
z1=randn(1000,1);			% Z1 ∼ N (0, 1) 
z2=randn(1000,1); 			% Z2 . . . same 
rho=0.5; 					% Choose some number for ρ. 
x1=z1; 
x2=rho*z1+(1-rho)*z2; 
corr(x1,x2)					% Big surprise.

%% Second step
z = randn(1000,2); 			% Produce z1 and z2 in one step. 
Sigma=[1 0.5; 0.5 1]; 		% Desired variance-covariance matrix. 
R = chol(Sigma);			% Perform a Choleski decomposition. 
x = z*R; 					% Produce correctly correlated random numbers. 
corr(x) 					% Now we get what we expected. 

%% More than 2 variables 
cor=[1 0.2 0.8; 0.2 1 -0.2; 0.8 -0.2 1]; 
A=chol(cor); 
X0 = randn(1000,3); 
X = X0*A; 
corr(X0) 
corr(X) 
B=cor^0.5;
X = X0*B; 
corr(X) 


%% Can we improve that? Take out initial correlations! 
cor=[1 0.2 0.8; 0.2 1 -0.2; 0.8 -0.2 1];  % Desired correlation matrix
A=chol(cor);         					  % Choleski decomposition
X0 = randn(1000,3);                       % Random numbers produced by MATLAB ...
corr(X0)             					  % ... are not perfectly uncorrelated.
B=chol(inv(corr(X0))); 					  % To take out initial correlations ...
X0better=X0*B;       					  % ... multiply by Choleski decomposition of inverse.
corr(X0better)       					  % Much closer to unity.
Xsimple=X0*A;							  % Correlated random numbers based on simple version
Xbetter=X0better*A;					      % Correlated random numbers based on improved version
corr(Xsimple)        					  % Simple correlated numbers are quite far from ...
corr(Xbetter)        					  % ... the desired correlation matrix.
