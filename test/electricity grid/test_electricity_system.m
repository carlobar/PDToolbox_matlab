% example of a game with one population, three strategies per population, and combined dynamics.

path(path, '../../revision_protocols')
path(path, '../../graphs')
path(path, '../../dynamics')
path(path, '../../')


% TODO:
% review how are the transitions between dynamics
% review why rd and logit are so similar in aggregated evolution, but
% differents in incentives


% population games tool box
clear

global G


global beta_ef alpha_ef time_on time_off mp N T_ hybrid

N = 5;

% Definition of the electricity variables
Dt = 15*[51.8743   50.0011   48.6104    48.6384    51.1276    58.7756 ...
    61.0654   65.0167   69.6593    71.6363    75.3904    76.2807 ...
    73.4635   73.3627   74.6492    75.1194    74.8689    74.1951 ...
    78.2569   85.8935   83.5392    77.9073    68.6800   60.5177];
pt = Dt./max(Dt)*8;

T_ = length(Dt);

alpha_ef = zeros(N,T_);
% valuation parameters of all agents
for i=1:N
    alpha_ef(i,:) = pt(1:T_)*(1+.5*i/N) + 0. *rand(1,T_);
end

% parametros de la func. de costo agregado
beta_ef = 1;

% Time of the activation of either incentives or attacks
time_on = 2;
time_off = 4;









% number of populations
P = 5;

% number of pure strategies per population
n = 25;

mp = 30;
%x0 = [0.1 0.9;  0.2 0.8]'; 
%x0 = [.2 .6 .2];

dyn = {'rd'};
%dyn = {'smith', 'logit'};
%gamma = [.5, .5];
%gamma = [0, 1.0];
gamma = [1, 0];
% simulation parameters
time = 30;

pot_r = ones(N,T_+1)*mp/(T_+1);
zz = pot_r'/mp;
x0 = zz(:);
%x0 = pot_r/mp;
%pause

% structure with the parameters of the game
G = struct('P', P, 'n', n, 'f', @fitness_user, 'ode', 'ode113', 'time', time, 'step', 0.00001, 'x0', x0);

% random initial condition
%G = struct('P', P, 'n', n, 'f', @fitness_user, 'ode', 'ode23s', 'time', time, 'step', 0.00001);

% verify data of the game
G = definition(G);


G.step = .01;


% run different dynamics
G.dynamics = {'rd'};
G.run()
T_rd = G.T;
X_rd = G.X;
%size(T_rd)
%pause

G.dynamics = {'bnn'};
G.run()
T_bnn = G.T;
X_bnn = G.X;

%T_rd = T_bnn;
%X_rd = X_bnn;

G.dynamics = {'smith'};
G.run()
T_smith = G.T;
X_smith = G.X;


G.eta = .02;
G.dynamics = {'logit'};
G.run()
T_logit = G.T;
X_logit = G.X;

%pause
graph_incentives_evolution

%G.dynamics = dyn;
%G.gamma = gamma;

%G.graph()
G.graph_state()
%G.graph_evolution()
%pause


