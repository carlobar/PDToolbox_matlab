function dz = combined_dynamics(t,z)

global G
n = max(G.S);
dz = zeros(G.P * n, 1);
dz_i = zeros(G.P * n, 1);

for i = 1 : length(G.dynamics)
	if G.gamma(i) ~= 0
		command = strcat( G.dynamics{i}, '(t,z)');
		dz_i = eval( command );
		dz = dz + G.gamma(i) * dz_i;
	end		
end



