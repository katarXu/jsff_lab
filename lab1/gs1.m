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
    for i = 1:9
        x2(i) = f(i);
        for j = 2:i + 1
            x2(i) = x2(i) + S(i, j) * x1(j);
        end
    end
    x2(10) = f(10);
    for j = 2:10
        x2(10) = x2(10) + S(10, j) * x1(j);
    end
    k = k + 1;
    vecNorm(k) = max(abs(x2 - exact))/normInf;
end
toc
%figure
%semilogy(vecNorm)
%title('gauss-seidel');