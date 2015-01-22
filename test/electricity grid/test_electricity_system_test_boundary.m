path(path, '../../revision_protocols')
path(path, '../../graphs')
path(path, '../../dynamics')
path(path, '../../')


clear

l = 10;
ith = 1;


global G

global beta_ef alpha_ef mp N T_


size_P = 2:2:200;

U_pareto = zeros(1, length(size_P));
U_nash = zeros(1, length(size_P));

X_pareto = zeros(1, length(size_P));
X_nash = zeros(1, length(size_P));

% Definition of the electricity variables
Dt = 15*[51.8743   50.0011   48.6104    48.6384    51.1276    58.7756 ...
    61.0654   65.0167   69.6593    71.6363    75.3904    76.2807 ...
    73.4635   73.3627   74.6492    75.1194    74.8689    74.1951 ...
    78.2569   85.8935   83.5392    77.9073    68.6800   60.5177];
pt = Dt./max(Dt)*8;


T_ = length(Dt);



for k=1 : length(size_P)

    disp (['Running  N=', num2str(size_P(k)), '... ']);
    
N = size_P(k);

% valuation parameters of all agents
alpha_ef = zeros(N,T_);
for i=1:N
    alpha_ef(i,:) = pt(1:T_)*(1 + 0 * .5*i/N) + 0. *rand(1,T_);
end

% parametros de la func. de costo agregado
beta_ef = 1;



% definition of the game structure

% number of populations
P = N;

% number of pure strategies per population
n = 25;
mp = 30;
m = ones(P, 1) * mp;
dyn = {'rd'};

% simulation parameters
time = 30;

pot_r = ones(N,T_+1)*mp/(T_+1);
zz = pot_r'/mp;
x0 = zz(:);

% structure with the parameters of the game
G = struct('P', P, 'n', n, 'f', @fitness_user, 'ode', 'ode113', 'time', time, 'step', 0.00001, 'x0', x0, 'm', m);

% random initial condition
%G = struct('P', P, 'n', n, 'f', @fitness_user, 'ode', 'ode23s', 'time', time, 'step', 0.00001);

% verify data of the game
G = definition(G);

G.step = .01;


% run game
G.dynamics = {'rd'};
G.run()
T_dyn = G.T;
X_dyn = G.X;



% extract matrix of strategies
%n = max(G.S);
x_n = vec2mat(X_dyn(end, :), n);
x_i = zeros(G.P, n);

for p = 1 : G.P
    x_i(p, :) = x_n(p, :) * G.m(p);
end

%U_i = utility_incentives(x_i);
U_i = utility(x_i);

U_pareto(k) = sum( sum( U_i(:, l) ) );
X_pareto(k) = sum( sum( x_i(:, l) ) );





% run the simulations with the inneficient case
G.f = @fitness_user_inefficient;
G.run()
X_dyn = G.X;

% extract matrix of strategies
%n = max(G.S);
x_n = vec2mat(X_dyn(end, :), n);
x = zeros(G.P, n);

for p = 1 : G.P
    x(p, :) = x_n(p, :) * G.m(p);
end

U = utility(x);

U_nash(k) = sum( sum( U(:, l) ) );
X_nash(k) = sum( sum( x(:, l) ) );

%figure(3); plot(1:1:24, U(ith, 1:24), 1:1:24, U_i(ith, 1:24), 'r')
%figure(4); plot(1:1:24, x(ith, 1:24), 1:1:24, x_i(ith, 1:24), 'r')

end

figure(1)
clf
plot(size_P, U_nash ./ U_pareto )


figure(2)
clf
plot(size_P, X_pareto ./ X_nash )
hold on
plot(size_P, (size_P+1)./(2*size_P), '--k')
hold off













