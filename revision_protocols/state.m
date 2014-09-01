function z = state(s)

global G

% find the current social state 
z = zeros(1, G.S(1));

for i = 1: G.S(1)
    z(i) = sum(s == i) / G.N;
end

