 % A quick program to test the MatLab debug functions
% MATLAB course 2012
% peter.gruber@usi.ch

% Try to change the code such that it conforms with the comments

% We simulate an AR(1) process over 100 innovations
a = randn(100,1);
b(1)=0;
for i = 2:100
    b(i)=0.9*b(i-1)+a(i);
end
figure
plot(b);
axis([0 100 -10 10])

%% Then we make a plot of the function x^2-x in the interval (0:1)
N=50;
x=linspace(0,1,N);
for t=1:N
    c(t) = x(t)^2-x(t);
end
figure
plot(x,c);

%% A plot of 10 random walks over 100 time steps
rn = randn(100,10);
rw = cumsum(rn,1);
plot(rw);

%% Finally let us check the distribution of some random numbers
low=0;
high=0;
numbers = round(rand(200,1)*10)/10;
for i=1:length(numbers)
    if numbers(i)<=0.5
        low = low+1;
    end
    if numbers(i)>0.5
        high=high+1;
    end
end
disp ('Total numbers - low - high');
disp ([length(numbers) low high]);
