function graph_fitness(name)
% GRAPH_FITNESS Plots the evolution of the fitness of each population.
%               There are no restrictions in the number of populations or
%               the number of strategies per population
% 
% SYNOPSIS: GRAPH_FITNESS(name)
% 
% INPUT name: Name of the structure that represents the game
% 
% REMARKS Its better to execute first <a href="matlab: help definition">definition</a> and <a href="matlab: help run_game">run_game</a> to plot the evolution
%         of strategies with G.graph_fitness()
%
% SEE ALSO definition, run_game, graph_evolution, graph_simplex, graph_multi_pop
%
% For more information see: <a href="https://github.com/carlobar/PDToolbox_matlab/">the GitHub's repository.</a>
% 
% Carlos Barreto, 04-11-16 


% load the structure of the game that calls the function
G = evalin('base', name);


cc=hsv(max(G.S));
n = max(G.S);

figure(5)
clf 
for p = 1 : G.P
	utility = zeros( length(G.T), G.S(p) );
	utility_mean = zeros( length(G.T), 1 );
	for t = 1: length(G.T)
        	utility(t, :) =  G.f(G.X(t, (p-1)*n + 1 : G.S(p) ), p);
		utility_mean(t) = utility(t, :) * G.X(t, (p-1)*n + 1 : G.S(p) )';
	end
    subplot(G.P, 1 ,p);
    hold on
    labels = cellstr('');
    for s = 1 : G.S(p)
        plot(G.T, utility(:, s), 'color', cc(s, :));
		plot(G.T, utility_mean, 'k');
	labels(s) = cellstr([num2str(s), '-th strategy']);
    end
    xlim([0 G.time])
    hold off

    title_i = ['Fitness of the ', num2str(p), '-th Population'];
    title(title_i)

    h = legend(labels);
    set(h, 'Interpreter', 'none')    
    xlabel('time')
end


