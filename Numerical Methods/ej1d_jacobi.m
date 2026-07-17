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

% Con el metodo iterativo de Jacobi
function x = Jacobi(A, b, maxIt, error)
    n = length(b);
    x = zeros(n,1);
    xPrev = x;

    for iteration = 1:maxIt
        for i = 1:n
            sum = 0;
            for j = 1:n
                if i ~= j
                    sum = sum + A(i,j) * xPrev(j);
                end
            end
            x(i) = (b(i) - sum) / A(i,i);
        end

        if norm(x - xPrev) < error
            break;
        end

        xPrev = x;
    end

endfunction

% 1d) Resolver con el metodo de Jacobi con Error <10^-6
x = Jacobi(A, b, 1000, 1e-06);

disp("Con el metodo de Jacobi:")
disp("x = ");
disp(x);
