clear,clc

syms x;
f = @(x) sin(x);
x0 = 1.2;
maxrept = 200;
tmp0 = cos(1.2);

B = ones(1, 16);
for p = 0 : 15
    h = 10 ^ (-p);
    for k = 5 : 15
        epsilon = 10^(-k);
        A = zeros(1, maxrept);
        A(1) = N1(f, x0, h);
        tmp1 = 0;
        for i = 1 : maxrept
            tmp1 = A(1);
            A(i + 1) = N1(f, x0, h / 2 ^ i);
            for j = i : -1 : 1
                A(j) = A(j + 1) + (A(j + 1) - A(j)) / (2 ^ (i - j + 1) - 1);
            end
            if abs(tmp1 - A(1)) < epsilon
                B(p + 1) = A(1);
                break;
            end
        end
        if i == maxrept
            %fprintf('h : %e\texceed\n', h);
        end
    end
    fprintf('h : %e\tepsilon : %e\ttimes : %d\tres : %.15f\terror : %e\n', 10^(-p),10^(-k), i, B(p+1), abs(B(p+1) - tmp0));
end
semilogy(abs(B - tmp0))

function [res] = N1(f, x0, h)
    res = (f(x0 + h) - f(x0)) / h;
end