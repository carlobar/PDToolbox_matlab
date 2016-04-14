function f_i = fitness2(x, p)

A = zeros(2,2,2);

A(:, :, 1) = [2 1; ...
              1 2];

A(:, :, 2) = [1 2; ...
              2 1];

Ai = squeeze(A(:, :, p));

p_ = p + (-1)^(p+1);

f_i =  Ai * x(p_, :)';
