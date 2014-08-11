function dz = bnn(t,z)

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
        F_(p, s) = G.f(x, p, s) ;
        F_mean(p) = F_mean(p) + x_n(p, s) * F_(p, s);
    end
end

F_excess = zeros(G.P, n);
F_excess_mean = zeros(G.P, n);

for p = 1 : G.P
    for s = 1 : G.S(p)
        F_excess(p, s) = max( F_(p, s) - F_mean(p), 0 ) ;
        F_excess_mean(p) = F_excess_mean(p) + F_excess(p, s);
    end
end


% calculate update in the strategy
x_dot_v = zeros(G.P* n, 1);
%x_dot = zeros(G.P, n);

for p = 1 : G.P
    for s = 1 : G.S(p)
        %x_dot(p, s) = F_excess(p, s) - F_excess_mean(p) * x_n(p, s);
        x_dot_v( (p-1)*n + s) = F_excess(p, s) - F_excess_mean(p) * x_n(p, s);
    end
end

%x_dot_ = x_dot';
%x_dot_v = x_dot_(:);

dz = [x_dot_v];


