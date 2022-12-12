% debugtest 4
% A short program to use the debugger tools
% Now with functions
% MatLab course 2006-02-02
% Peter Gruber

data=csvread('stock_data.csv',1,1);

for i=1:3
    data1=data(:,i);
    mean = debug_mean(data1);
    disp(mean);
end
