% run file
%function G = run(G)

%global G



command = strcat( G.ode, '( @', G.dynamics, ', [0 Time], G.x0, options_ode );');
tic
[T, X] = eval( command );
toc

G.T = T;
G.X = X;
