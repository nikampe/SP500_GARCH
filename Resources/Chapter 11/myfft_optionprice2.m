function MyFFTOptionPrice;

% MyFFTOptionPrice
% Compare Black Scholes, FFT and Cos-FFT methods 
% 2009-12-12, peter.gruber@usi.ch

%% ========== Setup and BS-Model ==========
r     = 0.1;        % risk-free rate
mu    = r;          % model parameters
sigma = 0.3;    
S0    = 100;          % Today's stock price
T     = 0.25;       % Time to expiry in years

K=70:130;
[C_BS,p,d1,d2] = blackS(S0,K,r,T,sigma);
subplot(2,1,1)
plot(K,C_BS,'r');
hold on

%% ========== FFT method ==========
%% STEP 1: Setup of FFT
% N ... number of grid points. N=2^K, usually K=12, N=4096
% \alpha ... damping parameter for the FFT sum

N      = 2^6;          % Numer of grid points, should be 2^n
alpha  = 1.4;           % value form Carr-Madan
a      = 200;           % upper limit of integration
eta    = a / N;         % Carr-Madan (18)
lambda = 2*pi/(N*eta);  % (23)
b      = N*lambda/2;    % (20)

%% Step 2: Introduce the characteristic function
% [see below as private function]
% .. and calculate psi from this (6)
phi=@(s,mu, sigma, T)exp((mu-0.5*sigma^2)*i*T.*s - 0.5*sigma^2*T*s.^2);  %vector-compatible in s

% .. and calculate psi from this (6)
psi=@(v, mu, sigma, T, alpha)exp(-mu*T) * phi(v-(alpha+1)*i,mu,sigma,T) ...
    ./ (alpha^2 + alpha - v.^2 + i*(2*alpha+1).*v);                      %vector-compatible in v

%% Step 3: Evaluate (24)
% k=\log K/S
% Range of interest for k: [-b, b]
j = 1:N;
vj = eta*(j-1);                			   % just above (17)
simp = (3+(-1).^j)/3;           		   % Simpson's weights (24)
simp(1) = 1/3;
psi_T=@(v)psi(v, mu, sigma, T, alpha);     % make a 1-variable anonymous function
xj = exp(i*b*vj) .* psi_T (vj)*eta.*simp;  % argument of FFT in (24)

%% Setp 4: perform FFT
u = 1:N;                                   % part of (19)
ku = -b + lambda*(u-1);                    % (19)
C_FFT = S0*exp(-alpha*ku)/pi.*real(fft(xj));   % (24) 

%% Step 5: strike prices
K = exp(ku)*S0;
subplot(2,1,1)
hold on
plot(K,C_FFT);
axis([S0*.7 S0*1.3 0 .3*S0]);
subplot(2,1,2)
C_BS2=blackS(S0,K,r,T,sigma);
subplot(2,1,2)
semilogy(K,abs(C_BS2-C_FFT)./C_BS2)
axis([S0*.7 S0*1.3 1E-16 1]);


%% ========== COS-FFT Method ==========
%% Step 1. Setup
scalea = -10; % how many standard deviations?
scaleb = 10; 
a      = scalea*sqrt(T)*sigma;
b      = scaleb*sqrt(T)*sigma;
bma    = b-a;
N      = 20;
k      = 0:N-1;
gamma  = k*pi/bma;
K      = 70:130;

%% Step 2: Prepare Uk terms
Uk = 2/bma * ( cosSerExp(a,b,0,b,k) - cosSer1(a,b,0,b,k) );
charfn=phi(gamma,mu,sigma, T);

%% Step 3: Calculate prices
for m=1:length(K)
    x  = log(S0/K(m));
    Fk = real(charfn .* exp(i*k*pi*(x-a)/bma) );
    Fk(1)=0.5*Fk(1);						% weigh first term 1/2
    C_COS(m) = K(m) * sum(Fk.*Uk) * exp(-r*T);
end
subplot(2,1,1)
hold on
plot(K,C_COS,'k:')
subplot(2,1,2)
hold on
semilogy(K,abs(C_BS-C_COS)./C_BS,'k--')
axis([S0*.7 S0*1.3 1E-16 1]);


end % of function


%% ========== Private functions of the model ==========
function phi=cf(s,mu,sigma, T)
% phi = E[exp(ius)]
% In the BS-Case, this is
phi=exp((mu-0.5*sigma^2)*i*T.*s - 0.5*sigma^2*T*s.^2);  %vector-compatible in s
end

function  [c,p,d1,d2] = blackS(S,X,r,T,sigma,q);
%Calculates Black-Scholes european option prices.
%
%  Usage:      [c,p,d1,d2] = blackS( S,X,r,T,sigma,[q] );
%
%  Inputs:     S      scalar or nx1 vector, possible current stock prices
%              X      scalar or nx1 vector, strike price
%              r      scalar, riskfree interest rate (continuously compounded)
%              T      scalar, time to expiry of option
%              sigma  scalar or nx1 vector, std in stock price evolution
%              [q]    scalar, dividend yield (continuously compounded), optional
%
%  Output:     c      nx1 vector, call option prices
%              p      nx1 vector, put option prices
%              d1     nx1 vector
%              d2     nx1 vector
%
%  Peter.Gruber@unisg.ch, February 2007
%  Based on code by Paul.Soderlind@unisg.ch
if nargin==6     % if dividend is specified, correct for it
    S = S * exp(-q*T);
end
d1 = ( log(S./X) + (r+1/2*sigma.^2)*T ) ./ (sigma*sqrt(T));
d2 = d1 - sigma*sqrt(T);
c  = S.*stdnCdf(d1) - X.*exp(-r*T).*stdnCdf(d2);
p  = c + X.*exp(-r*T) - S;                  %put-call parity
end

function cdf = stdnCdf(a);
cdf = 0.5 + 0.5*erf(a/sqrt(2));
end

function phi = ftcall(model, charfn, data)
  alpha=model.FFT.alpha;
  r = data.r;
  tau = data.tau;
  nu = model.FFT.nu;
  phi = exp(-r*tau) .* charfn ./ ((alpha + i*nu).*(alpha + 1 + i*nu));
end % of function

function chi=cosSerExp(a,b,c,d,k)
  % cosine series coefficients of exp(y); Oosterle (22)
  % INPUT     a,b ... 1x1     arguments in the cosine
  %           c,d ... 1x1     integration boundaries in (20)
  %           k   ... FFT.Nx1 values of k
  bma = b-a;
  uu  = k*pi/bma;
  chi = 1./ (1+ uu.^2 ) .* ...
      ( cos(uu*(d-a))*exp(d)-cos(uu*(c-a))*exp(c) + uu.*sin(uu*(d-a))*exp(d)-uu.*sin(uu*(c-a))*exp(c) );
end

function psi=cosSer1(a,b,c,d,k)
  % cosine series coefficients of 1; Oosterle (23)
  % INPUT     a,b ... 1x1     arguments in the cosine
  %           c,d ... 1x1     integration boundaries in (20)
  %           k   ... FFT.Nx1 values of k
  bma    = b-a;
  uu  = k*pi/bma;
  uu(1)  = 1;      % to avoid case differentiation (done 2 lines below)
  psi    = 1./uu .* ( sin(uu*(d-a)) - sin(uu*(c-a)) );
  psi(1) = d-c;
end
