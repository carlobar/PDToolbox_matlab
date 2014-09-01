% run game with a finite population
% population games tool box
clear

global G

% number of populations
P = 1;

% number of agents
N = 1000;

% number of pure strategies per population
n = 3;

% mass of the population
m = 1;

% initial condition
x0 = [0.2 .7 0.1]'; 

% simulation parameters
time = 50000;


% structure with the parameters of the game
G = struct('N', N, 'n', n, 'f', @fitness1, 'x0', x0, 'ode', 'ode113', 'time', time, 'eta', 0.02);


% verify data of the game
G = definition(G);




G.R = 1;


% set initial state
s = zeros(G.N, G.P);

h = 0;
for i = 1: max(G.S(1))
	p = floor(G.N * G.x0(i, 1));
	if ((p + h) <= G.N) && (p ~= 0)
		s(h + 1: h + p) = i;
		h = h + p;
	end
	
end

% choose a random strategy to complete the initial state vector
if h ~= G.N
	s(h + 1: G.N ) = unidrnd(G.S(1), 1, G.N - h);
end




% function to find the current distribution
%state = @(u, S) sum(u == S);

t_max = floor(G.time);


T = 1:1:t_max;
X = zeros( t_max, G.S(1) );


% Number of agents that update their strategy at each time instant
alarm = poissrnd( G.N * G.R, 1, t_max);

for t = 1: t_max

    
    % update society state
    z = state(s);

    
    % find the current payoff of each strategy
    F = zeros(G.S(1), 1) ;

    for i = 1: G.S(1)
        F(i) = G.f(z', 1, i);
    end

    
	% select users to update their actions at random
	update_agents = unidrnd(G.N, 1, alarm(t));
	
    %compare_agent = unidrnd(G.N, 1, alarm(t));
    
	% procedure to update the strategy of each agent    
    for k=1 : alarm(t)
        i = update_agents(k);
        
        s_update = s;
        
        %s_update(i) = pairwise_comparison(F, z, s, i, 1);
        s_update(i) = comparison2average(F, z, s, i, 1);
        %s_update(i) = proportional_imitation(F, z, s, i, 1);
        s_update(i) = logit_choice(F, z, s, i, 1);
        
% 
%         % update society state
%         z = state(s);
% 
%         % find the current payoff of each strategy
%         F = zeros(G.S(1), 1) ;
%         for i = 1: G.S(1)
%             F(i) = G.f(z', 1, i);
%         end
        
        
        
    end
    
    s = s_update;
    
    X(t, :) = z';


end

G.X = X;
G.T = T;

graph_simplex
graph_evolution
graph_utility