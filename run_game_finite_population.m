function run_game_finite_population(name)

global G

% load the structure of the game that calls the function
G = evalin('base', name);

% set initial strategy of each agent to satisfy the initial condition
protocol = func2str(G.revision_protocol);

if G.verb == true
    disp (['Running the ', protocol, ' revision protocol']);
    tic
end

s = zeros(G.N, G.P);

% calculate the intial strategy of each user given the proportions in x0
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

% set the number of iterations
t_max = floor(G.time);

T = 1:1:t_max;
X = zeros( t_max, G.S(1) );

% Number of agents that update their strategy at each time instant
alarm = poissrnd( G.N * G.R, 1, t_max);

for t = 1: t_max
   
    % update society state
    x = state(s);
    
    % find the current payoff of each strategy
    F = zeros(G.S(1), 1) ;
    F = G.f(x, 1);

	% select users to update their actions at random
	update_agents = unidrnd(G.N, 1, alarm(t));
	
	% procedure to update the strategy of each agent    
    for k=1 : alarm(t)
        i = update_agents(k);
        s_update = s;
        s_update(i) = G.revision_protocol(F, x, s, i, 1);

        % update society state

%         s = s_update;
%         x = state(s);        
%         F = G.f(x, 1);        
        
        
       
    end
    
    s = s_update;
    
    X(t, :) = x';


end


if G.verb == true
    toc
    disp([' '])
end


G.X = X;
G.T = T;


% save changes on the structure in the workspace
assignin('base', name, G);
clear G