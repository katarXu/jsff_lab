clc,close

f = @(x) x * exp(-x);

n = 2000;
x = 0:2/n:2;
for i = 1 : n + 1
    y(i) = f(x(i));
end
plot(x, y)