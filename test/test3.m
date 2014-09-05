% example of a game with one population, three strategies per population, and combined dynamics.

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

m = 1;
%x0 = [0.1 0.9;  0.2 0.8]'; 
x0 = [.2 .6 .2];

dyn = {'smith', 'logit'};
gamma = [.5, .5];
gamma = [0, 1.0];
gamma = [1, 0];
% simulation parameters
time = 60;

% structure with the parameters of the game
G = struct('P', P, 'n', n, 'f', @fitness1, 'x0', x0, 'dynamics', {dyn}, 'gamma', gamma, 'ode', 'ode45', 'time', time);

% verify data of the game
G = definition(G);



G.eta = .02;
%G.dynamics = dyn;
%G.gamma = gamma;
G.run()
G.graph()
G.graph_state()
G.graph_evolution()
%pause


