function s_i = logit_choice(F, z, s, i, p)
% LOGIT_CHOICE Computes the differece equation that describes the update of
%         the populations' state following the logit choice revision protocol. 
%         This revision protocol leads to the logit dynamics with a large 
%         number of agents
% 
% SYNOPSIS: s_i = LOGIT_CHOICE(F, z, s, i, p)
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
%          pairwise_comparison, proportional_imitation
%
% For more information see: <a href="https://github.com/carlobar/PDToolbox_matlab/">the GitHub's repository.</a>
% 
% Carlos Barreto, 04-11-16 

global G

j = unidrnd( G.S(p) );


eta = G.eta;
F_ = exp( F(1:G.S(p) ) / eta );
F_mean = sum(F_(:));

rho_ij =  F_(j) / F_mean;

% prob generator
change = ceil(rand - 1 + rho_ij / G.R);

if change == 1
	s_i = j;
else
	s_i = s(i);
end

if j == 3
	h=1;
end
