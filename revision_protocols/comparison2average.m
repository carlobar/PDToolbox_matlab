function s_i = comparison2average(F, z, s, i, p)
% COMPARISON2AVERAGE Computes the differece equation that describes the update
%         of the populations' state following the comparison to the average
%         payoff revision protocol. This revision protocol leads to the BNN
%         dynamics with a large number of agents
% 
% SYNOPSIS: S_I = COMPARISON2AVERAGE(F, z, s, i, p)
% 
% INPUT F: Vector with the payoff of each strategy
%       z: Vector with the society's state (distribution of strategies)
%       s: Vector with the strategy of each agent
%       i: ID of the agent that makes an update of its strategy
%       p: Population ID. The current version only supports finite games with
%          one population
% 
% OUTPUT s_i: Update of the agent's strategy
%
% SEE ALSO definition, run_game_finite_population, logit_choice, pairwise_comparison, 
%          proportional_imitation
%
% For more information see: <a href="https://github.com/carlobar/PDToolbox_matlab/">the GitHub's repository.</a>
% 
% Carlos Barreto, 04-11-16 

global G

j = unidrnd( G.S(p) );

pi_j = F( j );

rho_ij = max(pi_j - F' * z' / G.m, 0);

% prob generator
change = ceil(rand - 1 + rho_ij / G.R);

if change == 1
s_i = j;
else
	s_i = s(i);
end

