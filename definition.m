% check if parameters where defined. If not defined, then assign default
% values.
function G = definition(G)

global norm_dx c_error

norm_dx = 1;

% find the name of the structure that represents the game
G.name = inputname(1);

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
        G.x0( i, 1 : G.S(i) ) = x / sum(x);
    end
    G.x0 = G.x0';
end

% strategies used by default
if isfield(G, 'dynamics') == 0
    G.dynamics = {'rd'};
end

if isfield(G, 'revision_protocol') == 0
    G.revision_protocol = {'proportional_imitation'};
end

% check the definition of the combined dynamics
if length(G.dynamics) > 1
	if isfield(G, 'gamma') == 0
		G.gamma = ones(length(G.dynamics), 1) / length(G.dynamics);
	elseif length(G.dynamics) ~= length(G.gamma)
		exit('Size of G.gamma do not match the size do G.dynamics');
	end
end

% check parameters of the ODE
if isfield(G, 'ode') == 0
    G.ode = 'ode45';
end

if isfield(G, 'tol') ~= 0
    G.RelTol = G.tol;
	G.AbsTol = G.tol;
else
	if isfield(G, 'RelTol') == 0
		G.RelTol = .0001;
	end

	if isfield(G, 'AbsTol') == 0
		G.AbsTol = .0001;
	end
end

if isfield(G, 'step') == 0
    G.step = .01;
end

if isfield(G, 'time') == 0
    G.time = 30;
end

if isfield(G, 'stop_c') == 0
    G.stop_c = false;
else
	if isfield(G, 'c_error') == 0
		c_error = 1e-5;
	end
end

if isfield(G, 'options_ode') == 0 
    if (G.stop_c == true)
        G.options_ode = odeset('RelTol', G.RelTol, 'AbsTol', G.AbsTol, 'Events',@stopevent);
    else
        G.options_ode = odeset('RelTol', G.RelTol, 'AbsTol', G.AbsTol);
    end
end

% check the fitness function
if isfield(G,'f') == 0
    G.f = @fitness;
end

% decide if the fitness function returns the fitness of a single population
% of the fitness of the whole society
if isfield(G,'pop_wise') == 0
    G.pop_wise = true;
end

if isfield(G, 'R') == 0
    G.R = 1;
end

if isfield(G, 'N') == 0
    G.R = 100;
end

if isfield(G, 'verb') == 0
    G.verb = true;
end

% define functions 
G.run = @() run_game(G.name);
G.run_finite = @() run_game_finite_population(G.name);
G.graph = @() graph_simplex(G.name);
G.graph2p = @() graph_multi_pop(G.name);
G.graph_state = @() graph_final_state(G.name);
G.graph_evolution = @() graph_evolution(G.name);


    
