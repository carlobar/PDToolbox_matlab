% example of a game with one population, three strategies per population, and combined dynamics.

clear

% number of populations
P = 1;

% number of pure strategies per population
n = 3;

% Mass of the population 
m = 1;

% intial condition
x0 = [.1 .75 .15];

% Dynamics that will be combined
dyn = {'bnn', 'logit'};
gamma = [.75, .25];
% gamma = [0, 1];
% gamma = [1, 0];

% simulation parameters
time = 50;

% structure with the parameters of the game
G1 = struct('P', P, 'n', n, 'f', @fitness1, 'x0', x0, 'dynamics', {dyn}, 'gamma', gamma, 'ode', 'ode45', 'time', time);

% verify data of the game
G1 = definition(G1);

G1.eta = .02;
G1.run()


% Dynamics that will be combined
dyn = {'smith', 'rd'};
gamma = [.75, .25];

G2 = struct('P', P, 'n', n, 'f', @fitness1, 'x0', x0, 'dynamics', {dyn}, 'gamma', gamma, 'ode', 'ode45', 'time', time);

% verify data of the game
G2 = definition(G2);

G2.eta = .02;
G2.run()


% plot the evolution of the games
G1.graph()
G1.graph_evolution()

disp (['Press any key to continue...', sprintf('\n') ]);
pause


G2.graph()
G2.graph_evolution()


