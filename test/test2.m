% example of a game with two populations and two strategies per population.

clear

% number of populations
P = 2;

% number of pure strategies per population
n = 2;

% mass of the population
m = 1;

% initial condition
x0 = [0.1 0.9;  0.2 0.8]; 

% simulation parameters
time = 30;

% structure with the parameters of the game
G1 = struct('P', P, 'n', n, 'f', @fitness2, 'x0', x0, 'ode', 'ode45', 'time', time);

% The following game uses a random intial condition
% G1 = struct('P', P, 'n', n, 'f', @fitness2, 'ode', 'ode45','time', time);

% verify data of the game
G1 = definition(G1);

G1.dynamics = {'rd'};
G1.run()
G1.graph2p()
G1.graph_evolution()

disp (['Press any key to continue...', sprintf('\n') ]);
pause


G1.dynamics = {'maynard_rd'};
G1.run()
G1.graph2p()
G1.graph_evolution()

disp (['Press any key to continue...', sprintf('\n') ]);
pause


G1.dynamics = {'bnn'};
G1.run()
G1.graph2p()
G1.graph_evolution()

disp (['Press any key to continue...', sprintf('\n') ]);
pause


G1.dynamics = {'smith'};
G1.run()
G1.graph2p()
G1.graph_evolution()

disp (['Press any key to continue...', sprintf('\n') ]);
pause


G1.dynamics = {'logit'};
G1.eta = .02;
G1.run()
G1.graph2p()
G1.graph_evolution()


