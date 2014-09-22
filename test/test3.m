% example of a game with one population, three strategies per population, and combined dynamics.

path(path, '../revision_protocols')
path(path, '../graphs')
path(path, '../dynamics')
path(path, '../')

% population games tool box
clear

global G

% number of populations
P = 1;

% number of pure strategies per population
n = 3;

% Mass of the population 
m = 1;

% intial condition
x0 = [.1 .75 .15];

dyn = {'bnn', 'rd'};
gamma = [.25, .75];
%gamma = [0, 1.0];
%gamma = [1, 0];

% simulation parameters
time = 30;

% structure with the parameters of the game
G = struct('P', P, 'n', n, 'f', @fitness1, 'x0', x0, 'dynamics', {dyn}, 'gamma', gamma, 'ode', 'ode45', 'time', time);

% verify data of the game
G = definition(G);



G.eta = .02;
G.run()
G.graph()
G.graph_evolution()



