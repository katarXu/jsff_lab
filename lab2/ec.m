clc,close
syms x;
left = -1;
right = 1;
n1 = 2000;
m0 = 0;
mn = 0;
step1 = (right - left)/n1;
y = @(x) 1 / (1 + 25 * x.^2);
x1 = left:step1:right;

arr_n = [2.^2, 2.^3, 2.^4, 2.^5, 2.^6, 2.^7];
[~, ll] = size(arr_n);
maxn = zeros(1, ll);
for j = 2:7
    n = 2.^j;
    step = (right - left)/n;
    [Nx, fx] = newton(y, n, x1);
    maxn(j - 2 + 1) = max(abs(fx - Nx));
end
figure
%semilogy(x1, dev);
semilogy(arr_n, maxn)


function [Nx, fx] = newton(y, n, x1)
    sym y;  
    sym t;
    sym qb;
    syms x;
    rng(22);
    r = randperm(n + 1);
    qb = @(x) cos((r(x) - 1) * pi / n);
    g = zeros(1, n + 1);
    for i = 1 : n + 1
        g(i) = y(qb(i));
    end
    for i = 2 : n + 1
        for j = n + 1 : -1 : i
            g(j) = (g(j) - g(j - 1))/(qb(j) - qb(j - i + 1));
        end
    end
    [~, n1] = size(x1);
    t = ones(1, n1);
    Nx = zeros(1, n1);
    fx = zeros(1, n1);
    for i = 1 : n1        
        Nx(i) = y(qb(1));
        fx(i) = y(x1(i));
    end
    for i = 1 : n
        for j = 1 : n1
            t(j) = t(j) * (x1(j) - qb(i));
        end
        Nx = Nx + t * g(i + 1);
    end
end