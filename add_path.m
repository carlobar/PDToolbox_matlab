% ADD_PATH adds the toolbox's directories to the search path. 
%
% SEE ALSO definition, run_game, run_game_finite_population
%
% For more information see: <a href="https://github.com/carlobar/PDToolbox_matlab/">the GitHub's repository.</a>
% 
% Carlos Barreto, 04-11-16 

directory = pwd;

addpath(directory)
addpath(strcat(directory, '/revision_protocols') )
addpath(strcat(directory, '/graphs') )
addpath(strcat(directory, '/dynamics') )
