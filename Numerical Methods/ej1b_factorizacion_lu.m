% El sistema a resolver es Ax=b dado por las siguientes matrices
A = [3, -1, 0, 0, 0;
0, 5, 0, -1, 2;
1, -1, 9, 0, 0;
-2, 3, -1, 12, 1;
0, 0, -1, 1, 15];

b = [-1; 0; 1; 1; 0];

% El sistema a resolver
disp("El sistema a resolver:")
[n, m] = size(A);
for i = 1:n
    equation = "";
    for j = 1:m-1
        equation = strcat(equation, num2str(A(i,j)), "x", num2str(j), " + ");
    end
    equation = strcat(equation, num2str(A(i,m)), "x", num2str(m), " = ", num2str(b(i)));
    disp(equation);
end

% Con descomposicion LU
function x = LU(A, b)
    % LU factorization
    n = length(b);
    L = eye(n);
    U = A;

    for k = 1:n-1
        for i = k+1:n
            factor = U(i,k) / U(k,k);
            L(i,k) = factor;
            U(i,k:n) = U(i,k:n) - factor * U(k,k:n);
        end
    end

    % Forward substitution
    y = zeros(n,1);

    for i = 1:n
        y(i) = b(i) - L(i,1:i-1) * y(1:i-1);
    end

    % Back substitution
    x = zeros(n,1);

    for i = n:-1:1
        x(i) = (y(i) - U(i,i+1:n) * x(i+1:n)) / U(i,i);
    end

endfunction

% 1b) Resolver con factorizacion LU
x = LU(A, b);

disp("Con factorizacion LU:")
disp("x = ");
disp(x);
