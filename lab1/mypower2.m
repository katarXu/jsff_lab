clc;


A = [-148, -105, -83, -67
    488, 343, 269, 216
    -382, -268, -210, -170
    50, 38, 32, 29];
%A = -A;
[~,n] = size(A);
Xk = ones(n, 1);
maxrept = 1000;
epsilon = 1e-14;


Xk1 = A*Xk;
lamda0 = max(abs(Xk1));
Xk = Xk1;
for k = 2:maxrept
    Xk = Xk/norm(Xk,inf);
    Xk1 = A * Xk;
    lamda1 = max(abs(Xk1));
    if abs(lamda0 - lamda1) < epsilon
        fprintf('\nlamda = %20.15f\n', lamda0);
        Xk1
        break
    elseif abs(lamda0 + lamda1) < epsilon
        fprintf('\nlamda1 = %20.15f\n', lamda0);
        Xk1
        break
    end
    Xk = Xk1;
    lamda0 = lamda1;
    fprintf('%7d  %20.15f\n', k, lamda1);
end
