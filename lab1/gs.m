clc
%init
A = [
2 -1 0 0 0 0 0 0 0 0;
-1 2 -1 0 0 0 0 0 0 0;
0 -1 2 -1 0 0 0 0 0 0;
0 0 -1 2 -1 0 0 0 0 0;
0 0 0 -1 2 -1 0 0 0 0;
0 0 0 0 -1 2 -1 0 0 0;
0 0 0 0 0 -1 2 -1 0 0;
0 0 0 0 0 0 -1 2 -1 0;
0 0 0 0 0 0 0 -1 2 -1;
0 0 0 0 0 0 0 0 -1 2;
];
b = [2 -2 2 -1 0 0 1 -2 2 -2].';
exact = [1 0 1 0 0 0 0 -1 0 -1].';

[~,n] = size(A);
x1 = zeros(n,1);
x2 = ones(n,1);
normInf = max(abs(exact));
vecNorm = zeros(1,n);

L = tril(A,-1);
D = diag(diag(A));
U = triu(A,1);
I = eye(n);
rDL = I/(D + L);
S = -rDL * U;
f = rDL * b;
%precision
epsilon = 1e-15;

%gauss-seidel
k = 0;
tic
while norm(x1 - x2,inf)>epsilon
    x1 = x2;
    x2 = S * x1 + f;
    k = k + 1;
    vecNorm(k) = max(abs(x2 - exact))/normInf;
end
toc
%figure
%semilogy(vecNorm)
%title('gauss-seidel');