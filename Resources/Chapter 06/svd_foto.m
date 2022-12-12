%% compressing a foto using svd
% peter.gruber@unisg.ch
% 2006-11-22
% Change "max" in line 23

%% Read data
nash = imread('nash.jpg','JPEG');
nash = double(nash);
colormap(gray)
imagesc(nash);         % Original image

%% Perform SVD and have a look at singular values
[U,S,V] = svd(nash);
s1=diag(S);
s1(1:20)'
plot(s1(1:50))

%% Check if we can reproduce the image
figure;
nash2=U*S*V';
colormap(gray)
imagesc(nash2);

%% Now we cut the matrices
max=20;
U1=U(:,1:max);
S1=S(1:max,1:max);
V1=V(:,1:max);
nash3=U1*S1*V1';
figure
colormap(gray)
imagesc(nash3);

%% compare the sizes
n1=whos('nash');
txt=sprintf('Size of initial matrix is %0.5g kB',n1.bytes/1024);
disp(txt);

n2s=whos('S1');
n2v=whos('V1'); 
n2u=whos('U1'); 
txt=sprintf('Size of compressed matrix is %0.5g kB',(n2u.bytes+n2v.bytes+n2s.bytes)/1024);
disp(txt);