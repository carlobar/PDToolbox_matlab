% check if parameters where defined. If not assigned, assign default
% values.

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
    if floor(n) > 1
        G.S = ones(G.P, 1)*n;
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
end

% check if initial conditions where defined.
if isfield(G, 'x0') == 0
    G.x0 = zeros( G.P, max(G.S) );
    for i=1:G.P
        G.x0( i, 1 : G.S(i) ) = ones(1, G.S(i)) * G.m(i) / G.S(i);
    end
end

% check parameters of the ODE
if isfield(G, 'ode') == 0
    G.ode = 'ode45';
end

if isfield(G, 'dynamics') == 0
    G.dynamics = 'rd';
end

if exist('options_ode') == 0 
options_ode = odeset('RelTol', .0001, 'AbsTol', .0001);
end

% check the fitness function
if isfield(G,'f') == 0
    G.f = @fitness;
end

% define functions 
G.run = @run;
G.graph = @graph_simplex;
G.graph_state = @()graph_final_state();
G.graph_evolution = @(p)graph_evolution(p);


    