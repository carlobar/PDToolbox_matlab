function z = state(s)
% STATE Computes the strategy's proportion (social state)
% 
% SYNOPSIS: z = STATE(s)
% 
% INPUT s: Vector with the strategy of each agent
%       
% OUTPUT z: Vector with the social state
%
% SEE ALSO definition, run_game_finite_population, comparison2average, 
%          logit_choice, pairwise_comparison, proportional_imitation
%
% For more information see: <a href="GitHub: web('https://github.com/carlobar/PDToolbox_matlab/')">the GitHub's repository.</a>
% 
% Carlos Barreto, 04-11-16 


global G

% find the current social state 
z = zeros(1, G.S(1));

for i = 1: G.S(1)
    z(i) = sum(s == i) / G.N;
end

