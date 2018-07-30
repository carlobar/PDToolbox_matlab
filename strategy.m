function x = strategy(name, T)
% STRATEGY Computes the strategy of all populations at time T
% 
% SYNOPSIS: X = STRATEGY(name, T)
% 
% INPUT name: Name of the structure that represents the game
%       T: Time. 
% 
% OUTPUT X: Matrix with the strategies of the society at time T
%
% SEE ALSO definition, run_game
%
% For more information see: <a href="https://github.com/carlobar/PDToolbox_matlab/">the GitHub's repository.</a>
% 
% Carlos Barreto, 04-11-16 

% load the structure of the game that calls the function
G = evalin('base', name);

n = max(G.S);

% find the index t of the time instant T
if T < 0
    t = length(G.T);	
elseif T >= G.T(end)
    t = length(G.T);
else
    t = floor( T / G.step + 1);
end

% strategies normalized
x_n = vec2mat(G.X(t, :), n);

x = zeros(G.P, n);
for p = 1 : G.P
    x(p, :) = x_n(p, :) * G.m(p);
end

