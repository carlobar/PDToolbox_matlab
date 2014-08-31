function dz = maynard_rd(t, z)

global G

% extract matrix of strategies
n = max(G.S);
x_n = vec2mat(z,n);
x = zeros(G.P, n);

for p = 1 : G.P
    x(p, :) = x_n(p, :) * G.m(p);
end

% calculate fitness of each strategy
F_ = zeros(G.P, n);
F_mean = zeros(G.P, 1);

for p = 1 : G.P
    for s = 1 : G.S(p)
        F_(p, s) = G.f(x, p, s) * x_n(p, s);
        F_mean(p) = F_(p, s) + F_mean(p);
    end
end

% calculate update in the strategy
x_dot_v = zeros(G.P* n, 1);

for p = 1 : G.P
        x_dot_v ( (p-1)*n + 1 : p*n ) =  F_(p, :)'/ F_mean(p) - x_n(p, :)' ; 
end

dz = [x_dot_v];


