function run_game(name)

global G

% load the structure of the game that calls the function
G = evalin('base', name);


if length(G.dynamics) == 1
    if G.verb == true
        disp (['Running ', G.dynamics{1}, ' dynamics']);
    end
	command = strcat( G.ode, '( @', G.dynamics{1}, ',  G.step:G.step:G.time+G.step, G.x0, G.options_ode );');
else
    if G.verb == true
        names = strcat(G.dynamics{1});
        for i = 2: length(G.dynamics) 
            names =	strcat(names, ', ', ' ', G.dynamics{i});
        end
        disp (['Running combination of ', names, ' dynamics']);
    end
	command = strcat( G.ode, '( @combined_dynamics, G.step:G.step:G.time+G.step, G.x0, G.options_ode );');
% 	command = strcat( G.ode, '( @heuristic_combined_dynamics, G.step:G.step:G.time+G.step, G.x0, G.options_ode );');
end

if G.verb == true 
    tic
    [T, X] = eval( command );
    toc

    disp([' '])
else
    [T, X] = eval( command );
end
    
G.T = T;
G.X = X;

% save changes on the structure in the workspace
assignin('base', name, G);
clear G
