disp (['Running ', G.dynamics, ' dynamics']);

command = strcat( G.ode, '( @', G.dynamics, ', [0 G.time], G.x0, G.options_ode );');

tic
[T, X] = eval( command );
toc

disp([' '])

G.T = T;
G.X = X;
