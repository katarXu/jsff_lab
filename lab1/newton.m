clc;
syms x;
epsilon = 1e-15;
x1 = -1;
x2 = 1.1;
x3 = 3;
maxrept = 1000;
f(x) = x.^3 - 3 * x.^2 + 2;
y(x) = sin(4 * x.^2) + (sin(4 * x)).^2;

fprintf('%10s  %20s  %20s\n','k','x1','order');
res = newton1(f, x1, epsilon, maxrept);
fprintf('\n ans  = %20.15f\n\n', res);
fprintf('%10s  %20s  %20s\n','k','x2','order');
res = newton1(f, x2, epsilon, maxrept);
fprintf('\n ans  = %20.15f\n\n', res);
fprintf('%10s  %20s  %20s\n','k','x3','order');
res = newton1(f, x3, epsilon, maxrept);
fprintf('\n ans  = %20.15f\n\n', res);

function x2 = newton1(f, x0, epsilon, maxrept)
    syms x;
    g(x) = diff(f, x);
    x1 = x0 - f(x0)/g(x0);
    x2 = x1 - f(x1)/g(x1);
    order0 = log(abs(x2 - x1)/abs(x1 - x0));
    fprintf('%10d  %20.15f\n',1 ,x1);
    for k = 2:maxrept
        x2 = x1 - f(x1)/g(x1);
        order1 = order0;
        order0 = log(abs(x2 - x1)/abs(x1 - x0));
        x0 = x1;
        x1 = x2;
        fprintf('%10d  %20.15f  %20.15f\n',k ,x2, order0/order1);
        if abs(x1 - x0) < epsilon
            break;
        end
    end
end