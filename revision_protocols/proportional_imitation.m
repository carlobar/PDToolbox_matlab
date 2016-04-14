function s_i = proportional_imitation(F, z, s, i, p)
% PROPORTIONAL_IMITATION Computes the differece equation that describes the
%         update of the populations' state following the pairwise proportional
%         imitation revision protocol. This revision protocol leads to the
%         replicator dynamics with a large number of agents
% 
% SYNOPSIS: S_I = PROPORTIONAL_IMITATION(F, z, s, i, p)
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
% SEE ALSO definition, run_game_finite_population, comparison2average, 
%          logit_choice, pairwise_comparison
%
% For more information see: <a href="https://github.com/carlobar/PDToolbox_matlab/">the GitHub's repository.</a>
% 
% Carlos Barreto, 04-11-16 

global G

j = unidrnd( G.N );

pi_i = F( s(i) );
pi_j = F( s(j) );

rho_ij =  max(pi_j - pi_i, 0);

% prob generator
change = ceil(rand - 1 + rho_ij / G.R);

if change == 1
	s_i = s(j);
else
	s_i = s(i);
end

