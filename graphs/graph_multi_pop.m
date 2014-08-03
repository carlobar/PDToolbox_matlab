% graph the state space evolution of a population game with 
% two populations and two strategies

figure(4)
clf

plot(G.X(:, 1), G.X(:, G.S(1)+1) )


axis([0 1 0 1])
