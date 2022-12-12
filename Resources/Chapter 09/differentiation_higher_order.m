% Higher order differntiation schemes from Bronstein et al,
% Section 7.1.2, Table 7.13
%
% peter.gruber@usi.ch, 2012-12-17

% NOTATION: f ... function to be differentiated
%           g1x . schemes for 1st derivative
%           g2x . schemes for 2nd derivative
%           g3x . schemes for 3rd derivative

myh=10.^[-12:0.05:0.5];

% default setting
f = @(x)exp(x);
g1= @(x)exp(x);   % true first derivative
g2= @(x)exp(x);   % true second derivative
g3= @(x)exp(x);   % true third derivative
x0=0;

% interesting alternatives
% first try x^3 -- an odd function
% f =@(x)x.^3;
% g1=@(x)3*x.^2;  g2=@(x)6*x;
% g3=@(x)0;       x0=1;

% then try x^4-- an even function
% f =@(x)x.^4;
% g1=@(x)4*x.^3;   g2=@(x)12*x.^2;
% g3=@(x)24*x;     x0=1;

% function for calculating differentiation formulae
% coefficient vector runs [-2 .. 4]
fdiff=@(f,x,h,a)...
    a(1)*f(x-2*h)+a(2)*f(x-h)+a(3)*f(x)+...
    a(4)*f(x+h)+a(5)*f(x+2*h)+a(6)*f(x+3*h)+...
    a(7)*f(x+4*h);


%% ======= Schemes for first derivatives ==============
% right difference
% err \approx -1/2*h*y''
g10=@(f,x0,h) 1/(h)*( -f(x0-h)+f(x0) );

% central difference, first order
% err \approx -1/6*h^2*y'''
g11=@(f,x0,h) 1/(2*h)*( -f(x0-h)+f(x0+h) );

% central difference, second order
% err \approx +1/30*h^4*y^(5)
g12=@(f,x0,h) 1/(12*h)*( f(x0-2*h)-8*f(x0-h)+8*f(x0+h)-f(x0+2*h) );

% right difference, third order
% err \approx -1/20h^4*y^(5)
g13=@(f,x0,h) 1/(12*h)*...
    ( -3*f(x0-h)-10*f(x0)+18*f(x0+h)-6*f(x0+2*h)+f(x0+3*h) );

%% Testing the schemes for first derivative
myh=10.^[-12:0.05:0];
for u=1:length(myh)
    myg10(u)=g10(f,x0,myh(u));
    myg11(u)=g11(f,x0,myh(u));
    myg12(u)=g12(f,x0,myh(u));
    myg13(u)=g13(f,x0,myh(u));
    trueg10(u)=g1(x0);
end

figure
loglog(myh,abs(myg10-trueg10));
hold on
loglog(myh,abs(myg11-trueg10),'r');
loglog(myh,abs(myg12-trueg10),'g');
loglog(myh,abs(myg13-trueg10),'k');
legend('Right \propto h','Central \propto h^2', 'Central 2^{nd} \propto h^4',...
    'Right 3^{rd} \propto h^4','Location','North')
title('First derivatives')


%% ======= Schemes for second derivatives ==============
% central difference, first order
% err \approx -1/12*h^2*y^(4)
g21=@(f,x0,h)1/(h^2)*( f(x0-h)-2*f(x0)+f(x0+h) );

% central difference, second order
% err \approx +1/90*h^4*y^(6)
g22=@(f,x0,h)1/(12*h^2)*...
    ( -f(x0-2*h)+16*f(x0-h)-30*f(x0)+16*f(x0+h)-f(x0+2*h) );

% right difference, third order
% err \approx +11/12*h^2*y^(4)
g23=@(f,x0,h)1/(h^2)*...
    ( 2*f(x0)-5*f(x0+h)+4*f(x0+2*h)-f(x0+3*h) );

% right difference, third order, alternative
% err \approx +1/12*h^3*y^(5)
g24=@(f,x0,h)1/(12*h^2)*...
    ( 11*f(x0-h)-20*f(x0)+6*f(x0+h)+4*f(x0+2*h)-f(x0+3*h) );

% right difference, fourth order
% err \approx +1/12*h^5*y^(7)
g25=@(f,x0,h)1/(180*h^2)*...
    fdiff(f,x0,h,[-13 228 -420 200 15 -12 2]);
% the above is a shortcut for
% g25=@(f,x0,h)1/(180*h^2)*...
%     ( -13*f(x0-2*h)+228*f(x0-h)-420*f(x0)+...
%     200*f(x0+h)+15*f(x0+2*h)-12*f(x0+3*h)+2*f(x0+4*h) );


%% Testing the schemes for second derivative
myh=10.^[-8:0.05:0];
for u=1:length(myh)
    myg21(u)=g21(f,x0,myh(u));
    myg22(u)=g22(f,x0,myh(u));
    myg23(u)=g23(f,x0,myh(u));
    myg24(u)=g24(f,x0,myh(u));
    myg25(u)=g25(f,x0,myh(u));
    trueg20(u)=g2(x0);
end

figure
loglog(myh,abs(myg23-trueg20),'k');
hold on
loglog(myh,abs(myg21-trueg20),'r');
loglog(myh,abs(myg24-trueg20),'k--');
loglog(myh,abs(myg22-trueg20),'g');
loglog(myh,abs(myg25-trueg20),'b-');
legend('Right 3^{rd} \propto h^2','Central \propto h^2','Right 3^{nd} (altern) \propto h^3',...
    'Central 2^{nd} \propto h^4','Right 4^{th} \propto h^5','Location','North')
title('Second derivatives')


%% ======= Schemes for third derivatives ==============
% central difference, first order
% err \approx -1/4*h^2*y^(5)
g31=@(f,x0,h)1/(2*h^3)*...
    fdiff(f,x0,h,[-1 2 0 -2 1 0 0]);

% right difference, third order
% err \approx +1/4*h^2*y^(5)
g32=@(f,x0,h)1/(2*h^3)*...
    fdiff(f,x0,h,[0 -3 10 -12 6 -1 0]);

% average
g33=@(f,x0,h) 1/2*g31(f,x0,h) + 1/2*g32(f,x0,h)

%% Testing the schemes for third derivative
myh=10.^[-6:0.05:0];
for u=1:length(myh)
    myg31(u)=g31(f,x0,myh(u));
    myg32(u)=g32(f,x0,myh(u));
    myg33(u)=g33(f,x0,myh(u));
    trueg30(u)=g3(x0);
end

figure
loglog(myh,abs(myg31-trueg30),'r');
hold on
loglog(myh,abs(myg32-trueg30),'k');
loglog(myh,abs(myg33-trueg30),'b');
legend('Central \propto h^2','Right \propto h^2', 'Average \propto h^3',...
    'Location','North')
title('Third derivatives')

