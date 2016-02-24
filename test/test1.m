% example of a game with one population and three strategies per population.

clear

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
G1 = struct('n', n, 'f', @fitness1, 'x0', x0, 'ode', 'ode113', 'time', time,  'tol', 0.000001, 'step', .01);

% verify data of the game
G1 = definition(G1);


G1.dynamics = {'rd'};
G1.run()
G1.graph()
G1.graph_evolution()

disp (['Press any key to continue...', sprintf('\n') ]);
pause


G1.dynamics = {'maynard_rd'};
G1.run()
G1.graph()
G1.graph_evolution()

disp (['Press any key to continue...', sprintf('\n') ]);
pause


G1.dynamics = {'bnn'};
G1.run()
G1.graph()
G1.graph_evolution()

disp (['Press any key to continue...', sprintf('\n') ]);
pause


G1.dynamics = {'smith'};
G1.run()
G1.graph()
G1.graph_evolution()

disp (['Press any key to continue...', sprintf('\n') ]);
pause


G1.dynamics = {'logit'};
G1.eta = .02;
G1.run()
G1.graph()
G1.graph_evolution()