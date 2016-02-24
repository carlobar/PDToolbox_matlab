function dz = logit(t,z)

global G norm_dx

eta = G.eta;

% extract matrix of strategies
n = max(G.S);
x_n = vec2mat(z,n);
x = zeros(G.P, n);

for p = 1 : G.P
    x(p, :) = x_n(p, :) * G.m(p);
end

% calculate fitness of each strategy
F = zeros(G.P, n);
F_ = zeros(G.P, n);
F_mean = zeros(G.P, 1);
x_dot_v = zeros(G.P* n, 1);

if G.pop_wise == 0
	F(:, :) = G.f(x);
else
	for p = 1 : G.P
   		F(p, :) = G.f(x, p);
	end
end

for p = 1 : G.P
    F_(p, :) = exp( F(p, : ) / eta );
    F_mean(p) = F_(p, :) * ones(n, 1);

% calculate update in the strategy
    x_dot_v( (p-1)*n + 1 : p*n) = F_(p, :) / F_mean(p) - x_n(p, :);
end

dz = [x_dot_v];
if G.stop_c == true
    norm_dx = norm(dz);
end

