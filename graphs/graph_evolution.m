function graph_evolution(name)
% GRAPH_EVOLUTION Plots the evolution of the strategies of each population.
%                 There are no restrictions in the number of populations or
%                 the number of strategies per population
% 
% SYNOPSIS: GRAPH_EVOLUTION(name)
% 
% INPUT name: Name of the structure that represents the game
% 
% REMARKS Its better to execute first <a href="matlab: help definition">definition</a> and <a href="matlab: help run_game">run_game</a> to plot the evolution
%         of strategies with G.graph_evolution()
%
% SEE ALSO definition, run_game, graph_fitness, graph_simplex, graph_multi_pop
%
% For more information see: <a href="https://github.com/carlobar/PDToolbox_matlab/">the GitHub's repository.</a>
% 
% Carlos Barreto, 04-11-16 


% load the structure of the game that calls the function
G = evalin('base', name);


cc=hsv(max(G.S));
n = max(G.S);

figure(2)
clf 
for p = 1 : G.P

    subplot(G.P, 1, p);
    hold on
    labels = cellstr('');
    for s = 1 : G.S(p)
        plot(G.T, G.X(:, (p-1)*n + s), 'color', cc(s, :));
	labels(s) = cellstr([num2str(s), '-th strategy']);
    end
    ylim([0 1])
    xlim([0 G.T(end)])
    hold off

    title_i = ['Evolution of the ', num2str(p), '-th Population'];
    title(title_i)

    h = legend(labels);
    set(h, 'Interpreter', 'none')    
    xlabel('time')
end

