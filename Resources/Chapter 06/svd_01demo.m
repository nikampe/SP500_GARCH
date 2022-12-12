% Demo for the singular value decomposition
% peter.gruber@unisg.ch

X=gallery(3);                % sample data
[U,S,V] = svd(X);            % perform SVD
disp(U*U');                  % check if U,V orthogonal
disp(V*V');

%% Verify the full SVD
disp('Below: original X, full SVD, SVD(2) and SVD(1)');
disp(X);
disp(U*S*V');

%% Now let see if we can save some data
U = U(:,1:2);
V=V(:,1:2);
S=S(1:2,1:2);
disp(U*S*V');

%% Now let see if we can save even more data
U = U(:,1);
V=V(:,1);
S=S(1,1);

disp(U*S*V');

