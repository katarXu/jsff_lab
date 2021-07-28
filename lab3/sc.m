clc,close

f = @(x, y) x * exp(-4 * x) - 4 * y;

n = 2000;
h = 2 / n;

x = zeros(1, n);
y = zeros(1, n);
k1 = f(0, 0);
k2 = f(h / 2, h / 2 * k1);
x(2) = h;
y(2) = y(1) + h * k2;
k1 = f(h, y(2));
k2 = f(x(2) + h / 2, y(2) + h / 2 * k1);
x(3) = x(2) + h;
y(3) = y(2) + h * k2;
f1 = f(x(1), y(1));
f2 = f(x(2), y(2));
f3 = f(x(3), y(3));
for i = 3 : n
    x(i + 1) = x(i) + h;
    tmp = (y(i - 1) + h * (7/3 * f3 - 2/3 * f2 + 1/3 * f1));
    y(i + 1) = (y(i - 1) + h * (1/3 * f(x(i + 1), tmp) + 4/3 * f3 + 1/3 * f2));
    f1 = f2;
    f3 = f(x(i + 1), y(i + 1));
end

plot(x, y)