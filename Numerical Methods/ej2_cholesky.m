A = [4, 1, 2;
1, 2, 0;
2, 0, 5];

B = [-1; 0; 1];

% Get the Cholesky coefficients
g11 = sqrt(A(1,1));
g21 = A(2,1) / g11;
g31 = A(3,1) / g11;
g22 = sqrt(A(2,2)-g21^2);
g32 = (A(3,2)-g21*g31) / g22;
g33 = sqrt(A(3,3)-g31^2-g32^2);

G = [g11, 0, 0;
g21, g22, 0;
g31, g32, g33];

GT = transpose(G);

n = size(GT, 1);
Y = zeros(n,1);
X = zeros(n,1);

% Forward substitution
for i = 1:n
    Y(i) = (B(i) - G(i,1:i-1)*Y(1:i-1)) / G(i,i);
end

% Back substitution
for i = n:-1:1
    X(i) = (Y(i) - GT(i,i+1:end)*X(i+1:end)) / GT(i,i);
end


disp("X="), disp(X)
