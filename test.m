% population games tool box
clear

global G

% number of populations
P = 1;
% number of pure strategies per population
n = 4;
%S = [2 3]';
%S = ones(P, 1)*n;
% mass of each population
%m = ones(P,1);
m = 1;
x0 = [0.2 .4 0.3 .1]'; 

%G = struct('P', P, 'S', S, 'm', m, 'f', @fitness);


% we must check this
step = 0.001;
Time = 5;


G = struct('n', n, 'f', @fitness, 'x0', x0, 'ode', 'ode113');

%z0 = G.x0(:);


definition


G.dynamics = 'rd';
G.run()


G.dynamics = 'bnn';
G.run()

G.dynamics = 'smith';
G.run()






G.dynamics = 'logit';
G.eta = .02;
G.run()

G.graph()
G.graph_state()
G.graph_evolution(1)



