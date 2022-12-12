% flowdemo2.m
% A more efficient version of flowdemo.m
% MatLab class, 2006-11-02
% (c) 2005, 2006 Peter Gruber

timevec = clock;
% this is a vector [year month day hour minute seconds]
seconds = timevec(6);

if seconds == 0
    disp('The minute is beginning exactly now');
elseif  seconds < 15
     disp('We are in the FIRST quarter of the minute');
elseif  seconds < 30
     disp('We are in the SECOND quarter of the minute');
elseif  seconds < 45
     disp('We are in the THRID quarter of the minute');
else
     disp('We are in the LAST quarter of the minute');
end