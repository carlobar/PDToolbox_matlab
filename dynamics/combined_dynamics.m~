function dz = combined_dynamics(t,z)
% COMBINED_DYNAMICS Differential equation defined as the linear combinaiton
%        of other existing differential equations
% 
% SYNOPSIS: DZ = COMBINED_DYNAMICS(T, Z)
% 
% INPUT T: Time. Although the dynamics are time invariant, this parameter 
%          might be used to calculate the fitness function
%       Z: Vector of the populations' state
% 
% OUTPUT DZ: Vector with the value of the differential equation given T and Z
% 
% REMARKS Its better to execute first <a href="matlab: help definition">definition</a> and run the game using
%         G.run(). This function uses the global variables 'G' and 'norm_dx'
%         to define the game
%
% SEE ALSO definition, bnn, logit, rd, maynard_rd, smith_b, stopevent
%
% For more information see: <a href="https://github.com/carlobar/PDToolbox_matlab/">the GitHub's repository.</a>
% 
% Carlos Barreto, 04-11-16 

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



