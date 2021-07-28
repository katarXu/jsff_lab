clc,clear

f = @(x) exp(cos(x));
exact = 7.9549265210128452745132196653;

for i = 10 : 200
    step = 2 * pi / i;
    tmp = f(-pi)/2 + f(pi)/2;
    para = -pi + step;
    for j = 1 : i - 1
        tmp = tmp + f(para);
        para = para + step;
    end
    tmp = tmp * step;
    T(i - 9) = abs(tmp - exact);
end

semilogy(T)