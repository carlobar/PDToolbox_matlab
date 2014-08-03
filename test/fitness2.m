function f_i = fitness2(x, p, s)

A = zeros(2,2,2);

A(:, :, 1) = [2 1; ...
			  1 2];

A(:, :, 2) = [1 2; ...
			  2 1];

Ai = squeeze(A(:, :, p));
%Ai = squeeze(A(:, :, 1));
p_ = p + (-1)^(p+1);

f_i = x( p , s) * Ai(s, :) * x(p_, :)';
