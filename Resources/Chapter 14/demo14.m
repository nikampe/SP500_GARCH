% Code examples for parallel computing
% peter.gruber@usi.ch, 2022-10-20

%% Step 0: Time a simple task
tic
for k = 1:100
	U = randn(1000);
	inv(U);
end	
toc

%% Step 1: start a parpool
% Interesting: this takes quite some time
tic;myPool=parpool(2);toc               % number of workers
% Have a look at the blue bars at the bottom left of the MATLAB window

%% Info
myPool

%% Step 2: parallel job
tic
parfor k = 1:100
	U = randn(1000);
	inv(U);
end	
toc


%% Example with dependencies
% This will not work on the current parallel pool,
% because the workers cannot find the user-defined functions
for k=1:100
    data=rand(100,1);
    m(k)=myMean(data);
    v(k)=myVar(data);
end

%% Step  03: delete the pool
tic;delete(myPool);toc

%% Start a new pool WITH dependencies
fileList={'myMean.m','myVar.m'};
mypool=parpool('local',2,'AttachedFiles',fileList);
parfor k=1:100
    data=rand(100,1);
    m(k)=myMean(data);
    v(k)=myVar(data);
end

delete(myPool)


