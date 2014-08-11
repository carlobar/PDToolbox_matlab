if length(G.dynamics) == 1
	disp (['Running ', G.dynamics{1}, ' dynamics']);

	command = strcat( G.ode, '( @', G.dynamics{1}, ', [0 G.time], G.x0, G.options_ode );');
else
	names = strcat(G.dynamics{1});
	for i = 2: length(G.dynamics) 
		names =	strcat(names, ', ', ' ', G.dynamics{i});
	end
	disp (['Running combination of ', names, ' dynamics']);
	command = strcat( G.ode, '( @combined_dynamics, [0 G.time], G.x0, G.options_ode );');
end


tic
[T, X] = eval( command );
toc

disp([' '])

G.T = T;
G.X = X;
