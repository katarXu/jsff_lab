clc,close
n = 2^6;
n1 = 1000;
left = 0;
right = 1;
lx = @(x, k) (-1)^k / n * sin(n * pi * x) * cot(pi * (x - k / n));
y = @(x) sin(2 * pi * x) * exp(cos(2 * pi * x));

x0 = left:(right - left) / n:right;
x1 = left:(right - left) / n1:right;
fx = zeros(1, n1 + 1);
px = zeros(1, n1 + 1);
yx = zeros(1, n + 1);
for i = 1 : n + 1
    yx(i) = y(x0(i));
end
for i = 1 : n1 + 1
    fx(i) = y(x1(i));
    para = x1(i);
    for j = 0 : n - 1
        px(i) = px(i) +  lx(para, j) * yx(j + 1);
    end
end

err = abs(fx - px);
figure
semilogy(x1, err);
