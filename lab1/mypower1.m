clc;
rng(2)
A = rand(100);
[~,n] = size(A);
Xk = ones(n, 1);
maxrept = 1000;
epsilon = 1e-15;

p = 0.8 - 0.6i;
[L,U] = lu(A - p * eye(100));
mu1 = 0;
for k = 2:maxrept
    Xk1 = U\(L\Xk);
    Xk1 = Xk1/norm(Xk1,2);
    mu0 = dot(Xk1, A * Xk1);
    if abs(mu0 - mu1) < epsilon
        mu0
        Xk1
        break
    end
    mu1 = mu0;
    Xk = Xk1;
    fprintf('%7d  %20.15f\n', k, mu0);
end

