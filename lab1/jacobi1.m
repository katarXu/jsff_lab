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

D = diag(diag(A));
I = eye(n);x
rD = I/D;
R = I - rD * A;
g = rD * b;
%precision
epsilon = 1e-15;

%jacobi
k = 0;
tic
while norm(x1 - x2, inf)>epsilon
    x1 = x2;
    x2(1) = R(1, 2) * x1(2) + g(1);
    x2(10) = R(10, 9) * x1(9) + g(10);
    for i = 2:9
        x2(i) = R(i, i - 1) * x1(i - 1) + R(i, i + 1) * x1(i + 1) + g(i);
    end
    k = k + 1;
    vecNorm(k) = max(abs(x2 - exact))/normInf;
end
toc
figure
semilogy(vecNorm)
title('jacobi');