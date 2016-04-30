function run_game(name)
% RUN_GAME Solves the differential equation of a population game
% 
% SYNOPSIS: RUN_GAME(name)
% 
% INPUT name: Name of the structure that represents the game
% 
% The solution of the game, evolution of strategies X and the time T, is 
% attached to the game's structure 
% 
% REMARKS Its better to execute first <a href="matlab: help definition">definition</a> and run the game using G.run().
%         This function uses the global variable 'G' to define the game
%
% SEE ALSO add_path, definition, run_game_finite_population,
% combined_dynamics
%
% For more information see: <a href="https://github.com/carlobar/PDToolbox_matlab/">the GitHub's repository.</a>
% 
% Carlos Barreto, 04-11-16 

global G

% load the structure of the game that calls the function
G = evalin('base', name);


if length(G.dynamics) == 1
    if G.verb == true
        disp (['Running ', G.dynamics{1}, ' dynamics']);
    end
	command = strcat( G.ode, '( @', G.dynamics{1}, ',  G.step:G.step:G.time+G.step, transpose(G.x0), G.options_ode );');
else
    if G.verb == true
        names = strcat(G.dynamics{1});
        for i = 2: length(G.dynamics) 
            names =	strcat(names, ', ', ' ', G.dynamics{i});
        end
        disp (['Running combination of ', names, ' dynamics']);
    end
	command = strcat( G.ode, '( @combined_dynamics, G.step:G.step:G.time+G.step, transpose(G.x0), G.options_ode );');
% 	command = strcat( G.ode, '( @heuristic_combined_dynamics, G.step:G.step:G.time+G.step, G.x0, G.options_ode );');
end

% 
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

if any( isnan( X(:) ) )
    warning('The solution of the game has NaN values.')
end 

% save changes on the structure in the workspace
assignin('base', name, G);
clear G
