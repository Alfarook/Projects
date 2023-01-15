function DiagonalSum = diagsum(A,B) % This is the function 'diagsum' which takes in two arguments and returns DiagonalSum

product = A * B;                    % 'product' is a local/private variable which multiplies the two arguments together

x = diag(product)                   % The 'diag' function takes the principle diagonal of the matrix inputted and makes a 'n'*1 matrix

DiagonalSum = sum(x);               % The 'sum' function (when inputting a matrix) returns a row vector containing the sum of each column 
end                                 % Since we only have one column, it will return the sum of the entire matrix.

