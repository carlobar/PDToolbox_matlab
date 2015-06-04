function dz = bnn(t,z)

global G



% extract matrix of strategies
n = max(G.S);
x_n = vec2mat(z,n);
x = zeros(G.P, n);

for p = 1 : G.P
    x(p, :) = x_n(p, :) * G.m(p);
end

F_mean = zeros(G.P, 1);
F = zeros(G.P, n);

F_excess = zeros(G.P, n);
F_gamma = zeros(G.P, 1);

x_dot_v = zeros(G.P* n, 1);


for p = 1 : G.P
    F(p, :) = G.f(x, p);
    F_mean(p) = F(p, :) * x_n(p, :)';

    F_excess(p,:) = max( F(p, :) - F_mean(p), 0 );
    F_gamma(p) = F_excess(p, :) * ones(n, 1);

    x_dot_v( (p-1)*n + 1 : p*n ) = F_excess(p, :)  - F_gamma(p) * x_n(p, :);

end

dz = [x_dot_v];


