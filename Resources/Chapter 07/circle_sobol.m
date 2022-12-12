% circle_sobol.m
% Find the area of the unit circle by Monte Carlo Simulation, 
% and apply this to estimating pi via Monte Carlo.
% Inspired by I. Sobol "A primer for the MC method"
% Compare randomly generated points to Sobol numbers
%
% peter.gruber@usi.ch, 2010-10-25

%% step one: generate a 2D-Sobol sequence and a standard random sequence
clear
Nsim=1024*1024;
Nsets=2;
sob_set    = sobolset(2);
sob_points = net(sob_set,Nsim);
rand_points= rand(Nsim,2);
% note to the student: try to extend this to include the Halton set
% using hal_set=haltonset(2) and then follow the commands for the sobolset

%% A short excursion to Sobol numbers
% First 4 numbers in blue
% Next 12 numbers in red
% next 48 numbers in black
figure
% run  this line by line
plot(sob_points(1:4,1),sob_points(1:4,2),'.', 'MarkerSize',20);
axis([0,1,0,1],'square')
hold on
plot(sob_points(5:16,1),sob_points(5:16,2),'r.', 'MarkerSize',20);
axis([0,1,0,1],'square')
plot(sob_points(17:64,1),sob_points(17:64,2),'k.', 'MarkerSize',20);
axis('square')


%% Comparison: plot the first 1.024 points
figure
subplot(1,Nsets,1)
plot(sob_points(1:1024,1),sob_points(1:1024,2),'.');axis('square')
title('Sobol Points')
subplot(1,Nsets,2)
plot(rand_points(1:1024,1),rand_points(1:1024,2),'.');axis('square')
title('Random Points')

%% Calculate the value of pi using Nsim points
%  create 2D points between -1 and 1
x_sob  = 2*sob_points-1;
x_rand = 2*rand_points-1;

% squared radius
% We only take the coordinates for which r < 1
r2_sob =  x_sob(:,1).*x_sob(:,1)   + x_sob(:,2).*x_sob(:,2);
r2_rand = x_rand(:,1).*x_rand(:,1) + x_rand(:,2).*x_rand(:,2);

inside_sob  = x_sob(r2_sob<1,:);
inside_rand = x_rand(r2_rand<1,:);

% Show the circle
figure
subplot(1,Nsets,1)
plot(x_sob(:,1),x_sob(:,2),'.b');
hold on
plot (inside_sob(:,1),inside_sob(:,2),'k.'); axis('square')
title('Sobol Points')
subplot(1,Nsets,2)
plot(x_rand(:,1),x_rand(:,2),'.b');
hold on
plot (inside_rand(:,1),inside_rand(:,2),'k.'); axis('square')
title('Random Points')

% Calculate the area: A = r^2 * pi = pi
area_sob = 4 * size(inside_sob,1) / Nsim
area_rand = 4 * size(inside_rand,1) / Nsim

err_sob=area_sob-pi
err_rand=area_rand-pi

%% * Calculate distribution of distances
for k=1:Nsim
    dist_rand= (x_rand(:,1)-x_rand(k,1)).^2 + (x_rand(:,2)-x_rand(k,2)).^2;
    dist_sob = (x_sob(:,1)-x_sob(k,1)).^2 + (x_sob(:,2)-x_sob(k,2)).^2;
    neigh_dist_rand(k) = min(dist_rand(1:Nsim ~= k));  % do not compare with yourself
    neigh_dist_sob(k)  = min(dist_sob(1:Nsim ~= k));  % do not compare with yourself
end
neigh_dist_rand = sqrt(neigh_dist_rand);
neigh_dist_sob = sqrt(neigh_dist_sob);

figure
subplot(1,Nsets,1)
hist(neigh_dist_sob,0:0.01:0.12);
axis([0 0.12 0 600])
title('Sobol Points')
subplot(1,Nsets,2)
hist(neigh_dist_rand,0:0.01:0.12);
title('Random Points')
axis([0 0.12 0 600])

