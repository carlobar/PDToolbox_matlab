function graph_simplex(name)
% GRAPH_SIMPLEX Plots the evolution of games with one population and three
%               strategies per population
% 
% SYNOPSIS: GRAPH_SIMPLEX(name)
% 
% INPUT name: Name of the structure that represents the game
% 
% REMARKS Its better to execute first <a href="matlab: help definition">definition</a> and <a href="matlab: help run_game">run_game</a> to plot the evolution
%         of strategies with G.graph()
%
% SEE ALSO definition, run_game, graph_evolution, graph_fitness, graph_multi_pop
%
% For more information see: <a href="https://github.com/carlobar/PDToolbox_matlab/">the GitHub's repository.</a>
% 
% Carlos Barreto, 04-11-16 


% load the structure of the game that calls the function
G = evalin('base', name);

figure(1)
clf
hold on
plot3([0 1 0 0]', [1 0 0 1]', [0 0 1 0]', 'k')
plot3(G.X(:,1), G.X(:,2), G.X(:,3)); 
axis([0 1 0 1 0 1]); 
view(135,0)
hold off
title('Simplex')


