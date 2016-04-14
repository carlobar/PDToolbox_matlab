% funcion para simular la ecuacion diferencial
function dz = smith(t,z)

global G norm_dx

n = max(G.S);

F = zeros(G.P, n);
F_sum = zeros(G.P, n);
F_mean = zeros(G.P, n);
x_dot_v = zeros(G.P * n, 1);

% extract matrix of strategies
x_n = vec2mat(z, n);
x = zeros(G.P, n);


for p = 1 : G.P
    x(p, :) = x_n(p, :) * G.m(p);
end

if G.pop_wise == 0
	F(:, :) = G.f(x);
else
	for p = 1 : G.P
   		F(p, :) = G.f(x, p);
	end
end



for p = 1 : G.P
    A = ones(n,1)*F(p,:);
    M = max( zeros(n,n),  A - A' );

    F_sum(p, :) = M * ones(n,1);
    F_mean(p, :) = x_n(p,:) * M;

    x_dot_v((p-1)*n + 1 : p*n ,:) = F_mean(p,:) - x_n(p,:) .* F_sum(p,:);
end

dz = [x_dot_v];

if G.stop_c == true
    norm_dx = norm(dz);
end
