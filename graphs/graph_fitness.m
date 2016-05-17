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

utility = zeros( length(G.T), G.P * n );

utility_mean = zeros( length(G.T), G.P );
state = zeros(length(G.T), n);

for t = 1: length(G.T)
    x = G.state(G.T(t));
    state(t, :) = x(1, :);
    F = zeros(G.P, n);
    if G.pop_wise == 0
        F(:, :) = G.f(x);
    else
        for p = 1 : G.P
            F(p, :) = G.f(x, p);
        end
    end

    for p = 1 : G.P
        k = (p-1) * n;
        for s=1:G.S(p)
            utility(t, k + s) = F(p, s);
        end
        utility_mean(t, p) = F(p, :) * x(p, :)' / G.m(p) ;
    end

end

for p = 1 : G.P
    k = (p-1) * n;

    subplot(G.P, 1 , p);
    hold on
    labels = cellstr('');

    for s = 1 : G.S(p)
        plot(G.T, utility(:, k + s), 'color', cc(s, :));
        labels(s) = cellstr([num2str(s), '-th strategy']);
    end
    plot(G.T, utility_mean(:, p), 'k-.');
    labels( G.S(p)+1 ) = cellstr(['Weighted Avg. Population']);
    xlim([0 G.time])
    hold off

    title_i = ['Fitness of the ', num2str(p), '-th Population'];
    title(title_i)

    h = legend(labels);
    set(h, 'Interpreter', 'none')    
    xlabel('time')
end

