clc,close;

f = @(x) sin(x);
x0 = 1.2;

x1 = zeros(1, 16);
x2 = zeros(1, 16);
for i = 1 : 16
    x1(i) = 10^(1 - i);
    x2(i) = abs((f(x0 + x1(i)) - f(x0)) / x1(i) - cos(x0));
end

loglog(x1, x2)
