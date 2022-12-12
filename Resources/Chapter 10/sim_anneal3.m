%% Global minimum by simulated annealing
%  A very simple example
%  peter.gruber@unisg.ch, 2006-04-07

%% Do the following things
% (1) run and have a look, run several times
% (2) change the starting value in line 18 to 2
% (3) change the step size in line 19 to 0.01 and run several times
% (4) change the step size in line 19 to 0.5 and to 20, watch x-values
% (5) change the temperature function in line 23 to @(t)4*t^2;
% (6) change the energy function  in line 15 to E=@(x)(x/10).^2+sin(x)+0.2*sin(10*x);
%     and repeat (2) to (5)
%% Main program
% Energy function
%E=@(x)sin(x)+0.2*sin(10*x)+0.1*(x-1.2)^2;
E=@(x)(x/10).^2+sin(x)+0.2*sin(10*x);
fplot(E,[-2*pi,2*pi]);

s0 = 0;            % start value
step_size=0.05;    % default value is 0.05

%% Neighour function, temprarture function on [0,1], transition probability
neighbour = @(s) s+step_size*(2*round(rand)-1);
temp = @(t)t^2;
P = @(e, en, temp) max(en<e,exp((en-e)/(e+en))/10/temp);

% params
max_iter=10000;
e_max = -100000;
i=0;

%so far best solutions
sb = s0;
s = s0;
e = E(s0);
eb = E(e);
i=2;

% only for the output: save y, x values and transition prob
save_en=zeros(1,max_iter);    % save "energy" = y values
save_sn=zeros(1,max_iter);    % save "s" = x values
save_tr=zeros(1,max_iter);    % save actual transitions
    
while (i <= max_iter) && (e > e_max)
    sn=neighbour(s);
    foo(i)=sn-s;
    en=E(sn);
    if (en < eb) % saving the best solution
        sb = sn;
        eb = en;
    end
    if rand < P(e, en, temp(i/max_iter))
        s = sn;
        e = en;
        save_tr(i)=1;
    end
    save_en(i)=en;
    save_sn(i)=sn;
    i = i+1;
end
disp([sb,eb]);
subplot(3,1,1)
plot(save_en);
title('Development of y-values')
subplot(3,1,2)
plot(save_sn);
title('Development of x-values')
subplot(3,1,3)
%plot(smooth(save_tr,1000),'r-');
plot(save_tr,'r-');
axis([0 i 0 1.1])
title('Transitions')
