% example of a game with one population and three strategies per population.

path(path, '/home/carlos/git/PDToolbox_matlab/revision_protocols')
path(path, '/home/carlos/git/PDToolbox_matlab/graphs')
path(path, '/home/carlos/git/PDToolbox_matlab/dynamics')
path(path, '/home/carlos/git/PDToolbox_matlab')
path(path, '/home/carlos/git/PDToolbox_matlab/test')

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
time = 30;

% structure with the parameters of the game
G = struct('n', n, 'f', @fitness1, 'x0', x0, 'ode', 'ode113', 'time', time);

% verify data of the game
G = definition(G);
%G_ = definition(G);


G.dynamics = {'rd'};
G.run()
G.graph()
%G.graph_state()
G.graph_evolution()
pause



G.dynamics = {'maynard_rd'};
G.ode = 'ode23s';
G.run()
G.graph()
%G.graph_state()
G.graph_evolution()
pause


G.ode = 'ode113';
G.dynamics = {'bnn'};
G.run()
G.graph()
%G.graph_state()
G.graph_evolution()
pause



G.dynamics = {'smith'};
G.run()
G.graph()
%G.graph_state()
G.graph_evolution()
pause



G.dynamics = {'logit'};
G.eta = .02;
G.run()
G.graph()
%G.graph_state()
G.graph_evolution()





