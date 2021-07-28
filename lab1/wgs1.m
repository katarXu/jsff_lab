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
vecNorm = zeros(1,1);

L = tril(A,-1);
D = diag(diag(A));
U = triu(A,1);
I = eye(n);
%precision
epsilon = 1e-15;

w=1.6;
    x1 = zeros(n,1);
    x2 = ones(n,1);
    vecNorm = zeros(1,1);
    
    k = 0;
    S = (I + w * (D\L))\((1 - w) * I - w * (D\U));
    f = w * ((I + w * (D\L))\(D\b));
    
tic
while norm(x1 - x2,inf)>epsilon
    x1 = x2;
    for i = 1:9
        x2(i) = f(i);
        for j = 1:i + 1
            x2(i) = x2(i) + S(i, j) * x1(j);
        end
    end
    x2(10) = f(10);
    for j = 1:10
        x2(10) = x2(10) + S(10, j) * x1(j);
    end
    x2 = x2 + f;
    k = k + 1;
    vecNorm(k) = max(abs(x2 - exact))/normInf;
end
    %semilogy(vecNorm)
   % hold on
%end
toc
%legend('0.0','0.2','0.4','0.6','0.8','1.0','1.2','1.4','1.6','1.8','2.0');

%title('gauss-seidel');