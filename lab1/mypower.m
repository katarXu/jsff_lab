clc;


A = [-148, -105, -83, -67
    488, 343, 269, 216
    -382, -268, -210, -170
    50, 38, 32, 29];
A = [222, 580, 584, 786
    -82, -211, -208, -288
    37, 98, 101, 132
    -30, -82, -88, -109];
%A = -A;
[~,n] = size(A);
Xk = ones(n, 1);
maxrept = 1000;
epsilon = 1e-14;

lamda2 = 0;
lamda3 = 0;
for k = 2:maxrept
    Xk1 = A * Xk;
    lamda0 = max(abs(Xk1));
    Xk1 = Xk1/norm(Xk1,inf);
    Xk2 = A * Xk1;
    lamda1 = max(abs(Xk2));
    if abs(lamda0 - lamda1) < epsilon
        fprintf('\nlamda = %20.15f\n', sqrt(lamda0));
        Xk1
        break
    elseif abs(lamda0 + lamda1) < epsilon
        fprintf('\nlamda1 = %20.15f\n', -sqrt(lamda0));
        Xk1
        break
    elseif abs(lamda0 - lamda3) < epsilon && abs(lamda1 - lamda2) < epsilon
        Xk = Xk2;
        Xk2 = A * Xk2;
        lamda0 = sqrt(Xk2(1)/Xk1(1));
        lamda1 = -lamda0;
        fprintf('\nlamda1 = %20.15f\n', lamda0);
        Xk1 = Xk2 + lamda0 * Xk;
        Xk1 = Xk1/norm(Xk1,inf);
        Xk1
        fprintf('\nlamda2 = %20.15f\n', lamda1);
        Xk1 = Xk2 - lamda0 * Xk;
        Xk1 = Xk1/norm(Xk1,inf);
        Xk1
        break
    end
    Xk = Xk1;
    Xk1 = Xk2;
    lamda2 = lamda0;
    lamda3 = lamda1;
    fprintf('%7d  %20.15f\n', k, lamda1);
end
