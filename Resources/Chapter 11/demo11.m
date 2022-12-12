%% Code examples for section 11 of the script 
%  "Solving Economics and Finance Problems with MATLAB"
%  peter.gruber@usi.ch, 2010-12-12

%% Setup (change problem definition here)
format long
f=@(x)1/(sqrt(2*pi))*exp(-x.^2./2) ;	% Standard normal distribution
%f=@(x)x.^3;							% vector-compatible function
%f=@(x)x.^4;                            % try f=@(x)x.^3;
range   = [-1 0];						% integration range. 
										% Try [-1000 1000], [-1 0]
Npoints = 6;							% Number of points
										% Try 10, 100, 1000
dx = (range(2)-range(1)) / Npoints;	    % x-increment (="width of strips")

if mod(Npoints,2)
    warning('Simpsons rule works only for even N')
end
%% Midpoint rule
xMid = (range(1)+dx/2): dx :(range(2)-dx/2);	% midpoint values
yMid = f(xMid);								    % Function values 
FMid = sum(yMid*dx);				            % midpoint rule integral
fprintf('Midpoint rule : %17.15f\n',FMid)

%% Trapezoid rule
xTrp = range(1) : dx : range(2);				% trapezoid point values 
yTrp = f(xTrp);                                    % Function values
FTrp = 0;                                       % Initialize running sum		
for k=2:length(yTrp)                            % Loop over all trapezoids
	F_trap=FTrp + dx/2 * (yTrp(k-1)+yTrp(k));   % Add 1 trapeziod to sum
end
FTrp = dx*sum(yTrp .* [0.5 ones(1,Npoints-1) 0.5] );  % Alternative in 1 line
fprintf('Trapezoid rule: %17.15f\n',FTrp)

%% Simpson's rule
xSmp = range(1) : dx : range(2);				% Same values as tapez rule 
ySmp = f(xSmp);								    % Function values
FSmp = 0;									    % Initialize running sum		
for k=2:2:length(ySmp)-1				        % Loop over polynomial shapes
	FSmp=FSmp + dx/3 * (ySmp(k-1)+4*ySmp(k)+ySmp(k+1));  % Add 1 polynomial shape
end
weights=repmat([2 4], 1, floor(Npoints/2));     % Weights vector
weights(1)=1;                                   % First and last weights are 1
weights=[weights 1];
FSmp = dx* 1/3 * sum(ySmp .* weights);	 		% Alternative in 1 line
fprintf('Simpsons rule : %17.15f\n',FSmp)

%% MATLAB built-in command
Fquad = quad(f,range(1),range(2),1E-14);
fprintf('MATLAB quad() : %17.15f\n',Fquad)

fprintf('----------------------------\n')
fprintf('Midpoint-quad : %+7.4e\n',FMid-Fquad)
fprintf('Trapezoid-quad: %+7.4e\n',FTrp-Fquad)
fprintf('Simpson-quad  : %+7.4e\n',FSmp-Fquad)

%% A more systematic approach

Nvalues=[2 4:4:100];
for k=1:length(Nvalues)
    FMid(k)=intMidpoint(f,range(1),range(2),Nvalues(k));
    FTrp(k)=intTrapeziodal(f,range(1),range(2),Nvalues(k));
    FSmp(k)=intSimpson(f,range(1),range(2),Nvalues(k));
end

plot(Nvalues,FMid)
hold on
plot(Nvalues,FTrp,'r')
plot(Nvalues,FSmp,'k')
legend('Midpoint','Trapezoidal','Simpson')
xlabel('N')


figure
semilogy(Nvalues,abs(FMid-Fquad))
hold on
semilogy(Nvalues,abs(FTrp-Fquad),'r')
semilogy(Nvalues,abs(FSmp-Fquad),'k')
legend('Midpoint','Trapezoidal','Simpson')
xlabel('N')
ylabel('abs error')

figure
loglog(Nvalues,abs(FMid-Fquad))
hold on
loglog(Nvalues,abs(FTrp-Fquad),'r')
loglog(Nvalues,abs(FSmp-Fquad),'k')
legend('Midpoint','Trapezoidal','Simpson','Simpson 3/8')
xlabel('N')
ylabel('abs error')

%% An interesting identity
N=10;
disp(intTrapeziodal(f,0,1,N)+2*intMidpoint(f,0,1,N))
disp(3*intSimpson(f,0,1,2*N))


%% Finally, some built-in MATLAB commands
quad(f,-1,1)							% Standard quadrature
quad(f,-1.96,1.96)						% Just verifying the 95% confidence interval.
format long 							%
quad(f,-10,10)							% Compare default precision
quad(f,-10,10,1E-14)					% ... to increased target precision
quad(f,-1000,1000,1E-14) 				% Cannot fool quad with a wide interval

quadgk(f,-Inf,Inf)