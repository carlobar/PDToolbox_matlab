function graph_multi_pop(name)
% GRAPH_MULTI_POP Plots the evolution of games with two populations and two
%                 strategies per population
% 
% SYNOPSIS: GRAPH_MULTI_POP(name)
% 
% INPUT name: Name of the structure that represents the game
% 
% REMARKS Its better to execute first <a href="matlab: help definition">definition</a> and <a href="matlab: help run_game">run_game</a> to plot the evolution
%         of strategies with G.graph2p()
%
% SEE ALSO definition, run_game, graph_evolution, graph_fitness,  graph_simplex
%
% For more information see: <a href="https://github.com/carlobar/PDToolbox_matlab/">the GitHub's repository.</a>
% 
% Carlos Barreto, 04-11-16 

% load the structure of the game that calls the function
G = evalin('base', name);


figure(4)
clf

plot(G.X(:, 1), G.X(:, G.S(1)+1) )


axis([0 1 0 1])

title('Simplex')
