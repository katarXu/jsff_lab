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
normInf = max(abs(exact));
vecNorm = zeros(1,n);
k = 0;

%precision
epsilon = 1e-15;

%jacobi
D = diag(diag(A));
I = eye(n);
rD = I/D;
R = I - rD * A;
g = rD * b;
x1 = zeros(n,1);
x2 = ones(n,1);

while norm(x1 - x2,inf)>epsilon
    x1 = x2;
    x2 = R * x1 + g;
    k = k + 1;
    vecNorm(k) = max(abs(x2 - exact))/normInf;
end

figure
semilogy(vecNorm)
hold on

%gauss-seidel
L = tril(A,-1);
U = triu(A,1);
rDL = I/(D + L);
S = -rDL * U;
f = rDL * b;
k = 0;
x3 = zeros(n,1);
x4 = ones(n,1);
vecNorm2 = zeros(1,1);
while norm(x3 - x4,inf)>epsilon
    x3 = x4;
    x4 = S * x3 + f;
    k = k + 1;
    vecNorm2(k) = max(abs(x4 - exact))/normInf;
end

semilogy(vecNorm2)
hold on