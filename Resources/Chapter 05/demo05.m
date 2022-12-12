%% demo05.m ==================================
% demo programs for chapter 05 of the MATLAB script
% peter.gruber@usi.ch, 2013-10-10

%% ===== Simple MATLAB data structures

%% data structures
day1=0.01*randn(100,1);
day2=0.02*randn(150,1);
[day1 day2]                    % this produces an error message

%% better: cell array
ticks{1}=day1;
ticks{2}=day2;
for d=1:2
	rv(d)=var(ticks{d});
end
ticks{1}(1:10)

%% Working with calendar dates
datestr(0)                      % The start of all time stamps
mydate='2019-10-08'             % Date as a string
d=datenum(mydate)               % Unix date number
datestr(d)                      % Convert back to a date
datestr(d+0.75)                 % Fractional time stamps correspond to times of the day
datestr(d+86)                   % Which day is 86 days after this day?
peak=datenum('2000-03-10')      % The day of the NASDAQ peak
weekday(peak)                   % On which weekday was it?


%% fred2read example and working with GDP data
%  get the fred2read function from

%  http://www.mathworks.ch/matlabcentral/fileexchange/40912-fred2read
[calDate GDP header]=fred2read('GDPC1');
size(GDP)
GDP(1:10)
datestr(calDate(1:10))     % verify that we have quarterly data
plot(calDate,GDP,'k-')
datetick('x',10)

%% Find recessions
recess=zeros(length(GDP),1);
for t=3:length(GDP)
	if GDP(t)<GDP(t-1) && GDP(t-1)<GDP(t-2)
        recess(t)=1;
        recess(t-1)=1;
	end
end 
sum(recess)
mean(recess)

%% nice plot
figure
bar(calDate,recess*20000,'EdgeColor','none','FaceColor',[0.8 0.8 0.8],...
    'BarWidth',1);
hold on
plot(calDate,GDP, 'k')
datetick('x',10)

%% * compare this to the official NBER recession indicator
[calDateNBER recessNBER header]=fred2read('USRECQ');
bar(calDateNBER,recessNBER*10000,'EdgeColor','none','FaceColor',[0.5 0.5 0.5],...
    'BarWidth',1);
axis([calDate(1) calDate(end) 0 20000])    % show only the periods 1947-now
                                           % as USRECQ has a longer history
                                           % than GDPC1
%% some quandl links
% https://www.quandl.com/c/economics/gdp-by-country


%% ===== Working with tables

%% load first dataset (only econ grades)
student = readtable('studentSet01.csv');
size(student)
student.Properties.VariableNames
student(1:3,:) 
% or
% head(student,3)

%% load second dataset (larger dataset)
student_2 = readtable('studentSet02.csv');
size(student_2)
student_2.Properties.VariableNames
student_2(1:3,:)

%% our first join
join(student, student_2)

%% differently named variables ("matnuber" vs "studNumber")
student_3 = readtable('studentSet03.csv');
student_3.Properties.VariableNames
student_3(1:3,:)
student(1:3,:)

%% join with differently named key
join(student, student_3,'LeftKeys','studNumber','RightKeys','matnumber')

%% Extra observations
student_4 = readtable('studentSet04.csv');
size(student_4)
% Note
% student = short dataset
% student_4 = longer dataset

%% Joining datasets of different size
size(join(student,student_4))        % no problem if shorter set is left
size(join(student_4,student))        % error if shorter set is right
size(innerjoin(student_4,student))   % --> create "small" merged dataset
size(outerjoin(student_4,student))   % --> create "large" merged dataset

%% A new large dataset
studentNew = outerjoin(student_4,student);
size(studentNew)
studentNew.Properties.VariableNames

%% data subsets
studentNew(1:3,[2 3 4 8 1 5 6])
studentNew(1:3,{'country','arts'})

% does not work
studentNew( studentNew.country == 'DE' , {'math','arts'} )
% works
studentNew( strcmp(studentNew.country,'DE'), {'math','arts'} )
studentNew( studentNew.math>4, {'math','arts'} )