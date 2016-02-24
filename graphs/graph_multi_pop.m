% graph the state space evolution of a population game with 
% two populations and two strategies

function graph_multi_pop(name)

% load the structure of the game that calls the function
G = evalin('base', name);


figure(4)
clf

plot(G.X(:, 1), G.X(:, G.S(1)+1) )


axis([0 1 0 1])

title('Simplex')
