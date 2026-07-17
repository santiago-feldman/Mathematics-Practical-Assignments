A = [3, -1, 0, 0, 0;
0, 5, 0, -1, 2;
1, -1, 9, 0, 0;
-2, 3, -1, 12, 1;
0, 0, -1, 1, 15];

b = [-1, 0, 1, 1, 0];

function x = GaussSeidelMethod(A, b)

    n = size(A, 1);
    x = zeros(n,1);

    iteration = 0;
    error = Inf;

    while error > 10e-6
        xPrev = x;
        for i = 1:n
            x(i) = (b(i) - A(i,1:i-1)*x(1:i-1) - A(i,i+1:end) * xPrev(i+1:end)) / A(i,i);
        end
        error = norm(x - xPrev, inf);
        iteration = iteration + 1;
    end
end

x = GaussSeidelMethod(A, b);
disp("Solution:"), disp(x)
