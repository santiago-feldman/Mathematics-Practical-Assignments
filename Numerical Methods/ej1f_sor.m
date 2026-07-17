
A = [3, -1, 0, 0, 0; 0, 5, 0, -1, 2; 1, -1, 9, 0, 0; -2, 3, -1, 12, 1; 0, 0, -1, 1, 15];
b = [-1; 0; 1; 1; 0];
omega = 1.1;        % W
maxIter = 1000;     % Maximum number of iterations
tol = 1e-6;         % Error

function [x, iter] = sor(A, b, omega, maxIter, tol)

    n = size(A, 1);
    x = zeros(n,1);
    iter = 0;
    error = tol + 1;

    while (error > tol) && (iter < maxIter)
        xPrev = x;
        for i = 1:n
            sum1 = A(i,1:i-1) * x(1:i-1);
            sum2 = A(i,i+1:n) * xPrev(i+1:n);
            x(i) = (1 - omega) * xPrev(i) + (omega / A(i,i)) * (b(i) - sum1 - sum2);
        endfor

        error = norm(x - xPrev) / norm(x);
        iter = iter + 1;
    endwhile
endfunction

[x, iter] = sor(A, b, omega, maxIter, tol);

disp('Solution:');
disp(x);
disp('Number of iterations:');
disp(iter);
