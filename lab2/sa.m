clc,close
x = [2.1, 2.5, 2.8, 3.2];
y = [.6087, .6849, .7368, .8111];

a1 = 0;
a2 = 0;
a3 = 0;
a4 = 0;
b1 = 0;
b2 = 0;
for i = 1 : 4
    a1 = a1 + y(i)^2;
    a2 = a2 + x(i) * y(i)^2;
    a3 = a2;
    a4 = a4 + x(i)^2 * y(i)^2;
    b1 = b1 + x(i) * y(i);
    b2 = b2 + x(i)^2 * y(i);
end

res = [a1 a2; a3 a4;]\[b1; b2;];
fx = zeros(1, 4);
for i = 1 : 4
    fx(i) = x(i)/ (res(1, 1) + res(2, 1) * x(i));
end

norm(fx - y, 2)