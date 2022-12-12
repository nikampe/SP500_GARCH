% demo04.m
% demo programs for the chapter 04 of the MATLAB script
% peter.gruber@usi.ch

%% Produce a coin flip in MATLAB
myRandNum = rand          	   % 1 uniformly distributed draw
coin      = round(myRandNum)   % 1 coin flip

%% Introduction: coin.m
state=round(rand)      % Generate state (1=win, 0=loose)
if state == 1          % If plus (logical condition)
  disp('win')          % Executed if the (condition) is true
else
  disp('loose')        % Executed if the (condition) is false
end                    % Don't forget the end

%% Operators revisited
1 + 1 			       % An arithmetic operator takes two operands to produce a result
1 < 2 			       % A logical operator does exactly the same.
				       % Note: 1 means "true"
[1 3] < [2 2]	       % The result is[1 0],because (1<2) is true and (3<2) false.
all([1 3] < [2 2])     % is the condition fullfilled for all elements?
any([1 3] < [2 2])     % is the condition fullfilled for at least one element?
isequal(a,b)

%% Equality and floating-point numbers.
% Floating-point numbers are rarely exactly (up to 10−16) equal.
a=11.1+12.2; 
b=23.3; 
a==b
abs(a-b)/abs(a+b) < 1E-6

%% calculations with relational operators
grade = [4.0 4.5 3.5 5.0 5.5 2.5 6.0 5.5 3.5 4.0]   % some student grades
grade>=4        % passing grade
sum(grade>=4)
mean(grade>=4)

%% The result of the comparison can be assigned to a new variable
passingGrade = grade>=4
sum(passingGrade)               % in how many cases is data positive?

% Complementary condition with ~
sum(~passingGrade)               % in how many cases is data positive?

%% Tertia non datur ... always 1
mean(passingGrade) + mean(~passingGrade)

%% Logical indexing
% Create subset of only the passing grades
male = logical([0 0 1 1  1 1 0 1 0 0])
grade(male)
grade(~male)
grade(passingGrade)
grade(grade>=4)
% Complementary condition with ~
grade(~passingGrade)
grade(grade<4)

%% now we can calculate the mean of 
% (a) all grades  (b) only the passing grades (c) only the failing grades
[ mean(grade) mean(grade(passingGrade)) mean(grade(~passingGrade)) ]

%% *More calculations with relational operators
%  Multiply negative numbers with zero
data = [-1.1 0.2 -0.9 2.2 3 -1.8]           % some payoffs
data > 0
dataIsPos = data > 0
data.*dataIsPos
data.*(data>0)               % shorter, less easy to understand

%% if-else
% Now run flowdemo and flowdemo2

%% *comparing vectors
% "The statements [after the if] are executed if the real part
% of the expression has all non-zero elements." 
a=[1 2 3]; 
b=[1 2 4];
isequal(a,b)
a==b
if a==b
    disp('The vectors are equal');
else
    disp('The vectors are unequal');
end
% Now let us try the condition the other way round
if a~=b
    disp('The vectors are unequal');
else
    disp('The vectors are equal');
end
% why?
a~=b

%% Example: multiple, countable possibilities 
switch weekday(date)
         case {2,3,4,5}
             disp('Grum working days');
         case 6
             disp('Home at 12:00');
         case {7,1}
             disp('Weekend!');
         otherwise
             disp('Your calendar is broken');
end
% Have you been born on a weekend? Replace "date" with your birthday.

%% Logical operators
%  Example: marriage conditions 
rich=round(rand)		% randomly choose "rich" or "not rich"
famous=round(rand)
if rich & famous
   disp('I will marry you.')
else
   disp('Forget it.')
end

%% *Example: short-circuited operators
exist('foobar') & foobar>0    % note that the variable foobar does not exist
exist('foobar') && foobar>0   % note that the variable foobar does not exist
isJobless = 1;
isJobless | salary<2000       % Salary not defined for the unemployed
isJobless || salary<2000
isJobless = 0; salary = 1500;
isJobless | salary<2000

%% Conditional loops
ntry = 0;
head = 0;
while head < 3
    coin = round(rand(1,3));  	% 3 coins: 1=heads, 0=tails
    head = sum(coin);           % Number of "heads"
    ntry = ntry+1;
end
disp(ntry)

%% Faster
coinFn
% see also coinDist.m (later)

%% for-loops (1)
T=25;
% Recap: different ways to create a vector
[3 5 2.2 1.7]       %  Element by element
1:10                %  Increments of 1
1:T                 %  Increments of 1 up to T (must be defined previously)
1:0.5:10            %  Arbitrary increments
linspace(1,10,20)   %  Fixed number (here 20) of elements

%% Repeating the same command several times
disp('I will not forget the homework')    % 1
disp('I will not forget the homework')    % 2
disp('I will not forget the homework')    % 3
disp('I will not forget the homework')    % 4
disp('I will not forget the homework')    % 5
disp('I will not forget the homework')    % 6
disp('I will not forget the homework')    % 7
disp('I will not forget the homework')    % 8
disp('I will not forget the homework')    % 9
disp('I will not forget the homework')    %10

%% There must be a more efficient way
for k=1:10								  % 10 times
	disp('I will not forget the homework')
end

%% Repeating similar commands 
%  contribution of year_i to the present value
y = 1000;					% payment per period
r = 0.05;					% interest rate per period
payment(1) = y / (1+r)^1;	% contribution of first period
payment(2) = y / (1+r)^2;	% contribution of second period
payment(3) = y / (1+r)^3;	% contribution of thrid period
payment(4) = y / (1+r)^4;	% contribution of fourth period
payment(5) = y / (1+r)^5;	% contribution of fifth period
payment(6) = y / (1+r)^6;	% contribution of sith period
payment(7) = y / (1+r)^7;	% contribution of seventh period
presentValue=sum(payment)

%% Again, there must be a more efficient way
y = 1000;						% payment per period
r = 0.02;						% interest rate per period
clear payment
for k=1:7
	payment(k) = y / (1+r)^k;	% contribution of year k
end
presentValue=sum(payment)

%% What, if the interest rate changes with the duration?
r=linspace(0.05,0.07,7)
payment(1) = y / (1+r(1)) ^ 1;
payment(2) = y / (1+r(2)) ^ 2;
payment(3) = y / (1+r(3)) ^ 3;
payment(4) = y / (1+r(4)) ^ 4;
payment(5) = y / (1+r(5)) ^ 5;
payment(6) = y / (1+r(6)) ^ 6;
payment(7) = y / (1+r(7)) ^ 7;
presentValue=sum(payment)

%% Look up interest rate
r=linspace(0.05,0.07,7);
y=1000;
clear payment
for k=1:length(r)
	payment(k) = y / (1+r(k)) ^ k;	
end
presentValue=sum(payment)

% make the for loop consistent by using length(r)

%% What about half-yearly payments?
clear payment
r = 0.05
payment(1) = y / (1+r)^0.5;
payment(2) = y / (1+r)^1.0;
payment(3) = y / (1+r)^1.5;
payment(4) = y / (1+r)^2.0;
payment(5) = y / (1+r)^2.5;
payment(6) = y / (1+r)^3.0;
payment(7) = y / (1+r)^3.5;
presentValue=sum(payment)

%% Best solution -> make a list of durations
t=[0.5 1 1.5 2 2.5 3 3.5];		% list of durations
t=0.5:0.5:3.5;					% same, but simpler
r=linspace(0.05,0.07,7);
for k=1:7
	payment(k) = y / (1+r(k)) ^ t(k);	
end
presentValue=sum(payment)

%% Alternative solution 1 -> directly implment running sum of half-yearly payments
% Running sum: if the individual contributions are not reuires, sum within the loop
% Not good
PV=0;
r =0.05;
for k=0.5:0.5:7
	PV = PV + y / (1+r) ^ k;	
end

%% Alternative solution 2 -> complicated logic (transform loop variable)
% Not good
for k=1:7
	payment(k) = y / (1+r) ^ (k/2);	
end
presentValue=sum(payment)

%% Alternative solution 3 -> Running sum plus variable interest rates 
% Possible, but the logic is difficult to understand
% Not good
PV=0;
for k=0.5:0.5:3.5
	PV = PV + y / (1+0.05+(k-0.5)/150) ^ k;	
end
disp(PV)

%% ** Double for loop
% How does the present value depend on the (constant) interest rate?
rate = 0:0.01:0.5;
y = 1000;
for rCount = 1:length(rate)    % loop over all interest rates
    clear payment
	for k=1:7							 % Calculate the PV for interestRates(rCount)
		payment(k) = y / ( 1+rate(rCount) )^k;
	end
    allPV(rCount)=sum(payment);		% Save PV for interestRates(iCount) as element rCount
end
plot(rate,allPV);
axis([0 0.5 0 7000])