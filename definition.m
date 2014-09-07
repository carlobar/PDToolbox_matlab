% check if parameters where defined. If not defined, then assign default
% values.
function G = definition(G)

% check society size
if isfield(G, 'P') == 0
    G.P = 1;
else
    if G.P < 1
        exit('Invalid value of G.P.');
    end
end

% check number of pure strategies
if isfield(G,'n') ~= 0
    if floor(G.n) > 1
        G.S = ones(G.P, 1) * G.n;
    else
        exit('Invalid value of G.n.')
    end
else
    if isfield(G, 'S') == 0
        exit('Number of strategies per population must be defined.');
    elseif (size(G.S, 1) < G.P) 
        exit('Number of strategies not defined for some populations.')
    end
end
    
% check mass of each population
if isfield(G,'m') == 0
    G.m = ones(G.P, 1);
elseif size(G.m, 1) < G.P
    G.m = ones(G.P, 1);
    warning('Setting by the mass of all populations to 1.')
end

% check if initial conditions where defined.
if isfield(G, 'x0') == 0
    G.x0 = zeros( G.P, max(G.S) );
    for i=1:G.P
        x = rand(1, G.S(i));
        G.x0( i, 1 : G.S(i) ) = x * G.m(i) / sum(x);
    end
end

% check parameters of the ODE
if isfield(G, 'ode') == 0
    G.ode = 'ode45';
end

if isfield(G, 'dynamics') == 0
    G.dynamics = {'rd'};
end

if isfield(G, 'revision_protocol') == 0
    G.revision_protocol = {'proportional_imitation'};
end


if length(G.dynamics) > 1
	if isfield(G, 'gamma') == 0
		G.gamma = ones(length(G.dynamics), 1) / length(G.dynamics);
	elseif length(G.dynamics) ~= length(G.gamma)
		exit('Size of G.gamma do not match the size do G.dynamics');
	end
end



% simulation parameters
if isfield(G, 'step') == 0
    G.step = .0001;
end

if isfield(G, 'time') == 0
    G.time = 30;
end

% if isfield(G, 'iterations') == 0
%     G.time = 300;
% end

if isfield(G, 'options_ode') == 0 
	G.options_ode = odeset('RelTol', G.step, 'AbsTol', G.step);
end

% check the fitness function
if isfield(G,'f') == 0
    G.f = @fitness;
end


if isfield(G, 'R') == 0
    G.R = 1;
end

if isfield(G, 'N') == 0
    G.R = 100;
end

% define functions 
G.run = @run_game;
G.run_finite = @run_game_finite_population;
G.graph = @graph_simplex;
G.graph2p = @graph_multi_pop;
G.graph_state = @graph_final_state;
G.graph_evolution = @graph_evolution;


    
