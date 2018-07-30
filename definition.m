function G = definition(G)
% DEFINITION Checks the parameters of the game, assigns default values, and
%            defines functions to run the game and to plot the evolution of
%            the populations
% 
% SYNOPSIS: G2 = DEFINITION(G1)
% 
% INPUT G1: Structure with some parameters of the game
% 
% OUTPUT G2: Structure with all the parameters and functions required to run
%            a the game 
% 
% REMARKS This function uses the global variables "norm_dx" and "c_error".
%         Its recommended to avoid their use in other files because they 
% 	      might be overwritten
%
% SEE ALSO add_path, run_game, run_game_finite_population, bnn, logit, rd, 
%          maynard_rd, smith, smith_b, stopevent, combined_dynamics, 
%          comparison2average, logit_choice, pairwise_comparison, 
%          proportional_imitation
%
% For more information see: <a href="https://github.com/carlobar/PDToolbox_matlab/">the GitHub's repository.</a>
% 
% Carlos Barreto, 04-11-16 

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
    

% check if the initial conditions where defined (must be normalized)
if isfield(G, 'x0') == 0
    G.x0 = zeros( G.P, max(G.S) );
    for i=1:G.P
        x = rand(1, G.S(i));
        G.x0( i, 1 : G.S(i) ) = x / sum(x);
    end
else
    % check if the initial condition is well defined
    n = size(G.x0, 1);
    m = size(G.x0, 2);
    if ~( (n == G.P) && (m == max(G.S)) ) 
        if ( (m == G.P) && (n == max(G.S)) )
            G.x0 = G.x0';
        else      
            exit('Invalid initial condition. Size of G.x0 do not match with G.P and G.S.')
        end
    end
end


% check the mass of each population
if isfield(G,'m') == 0
    G.m = ones(G.P, 1);
elseif size(G.m, 1) == 1
    m = G.m;
    G.m = ones(G.P, 1)*m;
elseif size(G.m, 1) < G.P
    G.m = ones(G.P, 1);
    warning('Setting by the mass of all populations to 1.')
end


% check if the initial conditions match with the mass of the population
if abs(sum(G.x0, 2) - ones(G.P, 1)) >= eps(ones(G.P, 1))
    warning('Populations` initial state x0 does not match the mass m.')
end


% dynamics used by default
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

% check the ODE solver
if isfield(G, 'ode') == 0
    G.ode = 'ode45';
end

% if 'tol' is defined, then RelTol and AbsTol take its value
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

% check the time to run the game
if isfield(G, 'time') == 0
    G.time = 30;
end

% check the step between time samples
if isfield(G, 'step') == 0
    G.step = .01;
end

% check if the convergence stop criteria is enabled
if isfield(G, 'stop_c') == 0
    G.stop_c = false;
else
	if isfield(G, 'c_error') == 0
		c_error = 1e-5;
		G.c_error = c_error;
    	else
        	c_error = G.c_error;
	end
end

% define ODE solver options
if isfield(G, 'options_ode') == 0 
    if (G.stop_c == true)
        G.options_ode = odeset('RelTol', G.RelTol, 'AbsTol', G.AbsTol, 'Events', @stopevent);
    else
        G.options_ode = odeset('RelTol', G.RelTol, 'AbsTol', G.AbsTol);
    end
end

% check the fitness function
if isfield(G,'f') == 0
    G.f = @fitness;
end

% decide if the fitness function returns the fitness of a single population
% or the fitness of the whole society
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

% define functions to run the game
G.run = @() run_game(G.name);
G.run_finite = @() run_game_finite_population(G.name);

% define functions to plot the evolution of the game
G.graph = @() graph_simplex(G.name);
G.graph2p = @() graph_multi_pop(G.name);
G.graph_evolution = @() graph_evolution(G.name);
G.graph_fitness = @() graph_fitness(G.name);

% define a function that returns the matrix of the state at time T
G.state = @(T) strategy(G.name, T);

    
