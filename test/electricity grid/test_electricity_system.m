% example of a game with one population, three strategies per population, and combined dynamics.

% TODO:
% review how are the transitions between dynamics
% review why rd and logit are so similar in aggregated evolution, but
% differents in incentives

% population games tool box
clear

global G beta_ef alpha_ef time_on time_off mp N T_ hybrid b q_min

q_min=0;

N = 5;

% Definition of the electricity variables
Dt = 15*[51.8743   50.0011   48.6104    48.6384    51.1276    58.7756 ...
    61.0654   65.0167   69.6593    71.6363    75.3904    76.2807 ...
    73.4635   73.3627   74.6492    75.1194    74.8689    74.1951 ...
    78.2569   85.8935   83.5392    77.9073    68.6800   60.5177];
pt = Dt./max(Dt)*8;

% number of strategies
T_ = length(Dt);

% valuation parameters of all agents
alpha_ef = zeros(N,T_);
for i=1:N
    alpha_ef(i,:) = pt(1:T_)*(1+.5*i/N*0) + 0. *rand(1,T_);
end

% parametros de la func. de costo agregado
beta_ef = 1;
b = 0;

% Time of the activation of either incentives or attacks
time_on = 2;
time_off = 4;


% number of populations
P =N;

% number of pure strategies per population
n = 25;

% mass of the populations
mp = 25;
m = ones(P, 1) * mp;

% simulation parameters
time = 60;

% initial condition
pot = ones(N,T_+1)/(T_+1);
x0 = pot;

% structure with the parameters of the game
%G = struct('P', P, 'n', n, 'f', @fitness_user, 'ode', 'ode113', 'time', time, 'tol', 0.00001, 'x0', x0, 'm', m);

% random initial condition
G = struct('P', P, 'n', n, 'f', @fitness_user, 'ode', 'ode45', 'time', time, 'tol', 0.000001, 'm', m);

% verify data of the game
G = definition(G);

G.step = .01;
G.eta = .02;

% run different dynamics
G.dynamics = {'rd'};
G.run()
T_rd = G.T;
X_rd = G.X;



G.dynamics = {'bnn'};
G.run()
T_bnn = G.T;
X_bnn = G.X;


G.dynamics = {'smith'};
G.run()
T_smith = G.T;
X_smith = G.X;


% % extract matrix of strategies
% %n = max(G.S);
% x_n = vec2mat(X_dyn(end, :), n);
% x = zeros(G.P, n);
% 
% for p = 1 : G.P
%     x(p, :) = x_n(p, :) * G.m(p);
% end
% 
% U = utility(x);
% 
%pause

G.dynamics = {'logit'};
G.run()
T_logit = G.T;
X_logit = G.X;



% extract matrix of strategies
x_n = vec2mat(G.X(end, :), n);
x = zeros(G.P, n);
for p = 1 : G.P
    x(p, :) = x_n(p, :) * G.m(p);
end
U = utility(x);

figure(3); plot(1:1:24, U(:, 1:24))
figure(4); plot(1:1:24, x(:, 1:24))





%if min(X_logit == )

%min(X_logit)

graph_incentives_evolution
%G.graph_state()

%sum(G.x0(1:24, :))
