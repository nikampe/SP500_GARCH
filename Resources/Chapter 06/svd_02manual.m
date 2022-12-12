%% SVD_manual.m
% The singular value decomposition step-by-step
% 2007-06-20, peter.gruber@unisg.ch

% take some nonsquare sample data
X = [gallery(3); 54 20 44];

% MatLab's built-in SVD
[U, S, V] = svd(X, 'econ');

%% Prepare for manual SVD
size(X)
r=rank(X)
disp('X has full rank');

%% Now the manual SVD
lambda=eig(X*X');       % produce a column vector of eigenvalues
[V,D] = eig(X*X');      % produce V, the matrix of eigenvectors

% In order to sort eigenvalues *and* eigenvectors together, we construct a
% temporary matrix of both. Then we sort for the first column, which contains the
% eigenvalues (need to transpose V, because we can only sort rows)

% sort_matrix looks like this:

% lambda1    --- first eigenvector (row) ---
% lambda2    --- second eigenvector (row) ---
% ...        ...

sort_matrix     = [lambda V'];
sorted_matrix   = sortrows(sort_matrix ,-1);   % -1 ... sort in descending order
sorted_evalues  = sorted_matrix(1:r,1);        % First row = sorted eigenvalues
sorted_evectors = sorted_matrix(1:r,2:end)';   % All ohter rows = sorted eigenvectors

S_manu = diag(sqrt(sorted_evalues));
U_manu = sorted_evectors;

% and now exactly the same with X'X
lambda=eig(X'*X);
[V,D] = eig(X'*X);
sorted_matrix   = sortrows([lambda V'],-1);
sorted_evectors = sorted_matrix(1:r,2:end)';
V_manu = sorted_evectors;

%% Output and comparison
disp('Manual calculation:');
disp(U_manu);
disp(S_manu);
disp(V_manu);

%% Make the test
U_manu * S_manu * V_manu'
X
