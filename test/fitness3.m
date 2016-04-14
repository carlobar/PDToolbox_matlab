function f_i = fitness3(x, p, s)

A = zeros(2,2,2);

A(:, :, 1) = [2 1; ...
              1 2];

A(:, :, 2) = [1 2; ...
              2 1];

Ai = squeeze(A(:, :, p));

p_ = p + (-1)^(p+1);

f_i =  Ai(s, :) * x(p_, :)';
