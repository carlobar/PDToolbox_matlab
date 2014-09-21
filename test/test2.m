% example of a game with two population and two strategies per population.

% population games tool box
clear

global G

% number of populations
P = 2;

% number of pure strategies per population
n = 2;

m = 1;
x0 = [0.1 0.9;  0.2 0.8]'; 


% simulation parameters
time = 20;

% structure with the parameters of the game
%G = struct('P', P, 'n', n, 'f', @fitness2, 'x0', x0, 'ode', 'ode45', 'time', time);



% random intial condition
G = struct('P', P, 'n', n, 'f', @fitness2, 'ode', 'ode45','time', time);

% verify data of the game
G = definition(G);




G.dynamics = {'rd'};
G.run()
G.graph2p()
G.graph_evolution()

disp (['Press any key to continue...']);
pause




G.dynamics = {'maynard_rd'};
G.ode = 'ode23s';
G.run()
G.graph2p()
G.graph_evolution()

disp (['Press any key to continue...']);
pause



G.dynamics = {'bnn'};
G.run()
G.graph2p()
G.graph_evolution()

disp (['Press any key to continue...']);
pause



G.dynamics = {'smith'};
G.run()
G.graph2p()
G.graph_evolution()

disp (['Press any key to continue...']);
pause



G.dynamics = {'logit'};
G.eta = .02;
G.run()
G.graph2p()
G.graph_evolution()


