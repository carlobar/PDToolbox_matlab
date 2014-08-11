% example of a game with one population and three strategies per population.

% population games tool box
clear

global G

% number of populations
P = 1;

% number of pure strategies per population
n = 3;

% mass of the population
m = 1;

% initial condition
x0 = [0.2 .7 0.1 ]'; 

% simulation parameters
time = 5;

% structure with the parameters of the game
G = struct('n', n, 'f', @fitness1, 'x0', x0, 'ode', 'ode113', 'time', time);

% verify data of the game
G = definition(G);
G_ = definition(G);


G.dynamics = {'rd'};
G.run()
G.graph()
G.graph_state()
G.graph_evolution()
pause



G.dynamics = {'bnn'};
G.run()
G.graph()
G.graph_state()
G.graph_evolution()
pause



G.dynamics = {'smith'};
G.run()
G.graph()
G.graph_state()
G.graph_evolution()
pause



G.dynamics = {'logit'};
G.eta = .02;
G.run()
G.graph()
G.graph_state()
G.graph_evolution()





