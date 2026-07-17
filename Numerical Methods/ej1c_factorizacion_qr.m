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

% Con descomposicion QR
function x = QR(A, b)
    % QR factorization
    [m, n] = size(A);
    Q = zeros(m, n);
    R = zeros(n);

    for j = 1:n
        v = A(:,j);
        for i = 1:j-1
            R(i,j) = Q(:,i)' * A(:,j);
            v = v - R(i,j) * Q(:,i);
        end
        R(j,j) = norm(v);
        Q(:,j) = v / R(j,j);
    end

    % Back substitution
    y = Q' * b;

    n = size(R, 2);
    x = zeros(n,1);

    for i = n:-1:1
        x(i) = (y(i) - R(i,i+1:n) * x(i+1:n)) / R(i,i);
    end
endfunction

% 1c) Resolver con factorizacion QR
x = QR(A, b);

disp("Con factorizacion QR:")
disp("x = ");
disp(x);
