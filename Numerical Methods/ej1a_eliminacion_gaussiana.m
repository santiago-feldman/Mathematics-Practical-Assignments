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

% Eliminacion Gaussiana
function x = gaussianElimination(A, b)
    n = length(b);

    % Check determinant
    if det(A) == 0
        error("The determinant of matrix A is zero. The system may not have a unique solution.");
    end

    % Forward elimination
    for k = 1:n-1
        for i = k+1:n
            factor = A(i,k) / A(k,k);
            A(i,:) = A(i,:) - factor * A(k,:);
            b(i) = b(i) - factor * b(k);
        end
    end

    % Back substitution
    x = zeros(n,1);
    x(n) = b(n) / A(n,n);
    for i = n-1:-1:1
        x(i) = (b(i) - A(i,i+1:n) * x(i+1:n)) / A(i,i);
    end

endfunction

% 1a) Resolver por eliminacion Gaussiana
x = gaussianElimination(A, b);

disp("\nCon Eliminacion Gaussiana:")
disp("x = ");
disp(x);
