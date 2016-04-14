function dz = maynard_rd(t, z)
% MAYNARD_RD Computes the differential equation that describes the update of 
%            the populations' state following the Maynard replicator dynamcics
% 
% SYNOPSIS: DZ = MAYNARD_RD(T, Z)
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
% SEE ALSO definition, bnn, logit, rd, smith, smith_b, stopevent, combined_dynamics
%
% For more information see: <a href="https://github.com/carlobar/PDToolbox_matlab/">the GitHub's repository.</a>
% 
% Carlos Barreto, 04-11-16 

global G norm_dx

n = max(G.S); 

F = zeros(G.P, n);
F_mean = zeros(G.P, 1);
x_dot_v = zeros(G.P* n, 1);

% extract matrix of strategies
x_n = vec2mat(z, n);
x = zeros(G.P, n);

for p = 1 : G.P
    x(p, :) = x_n(p, :) * G.m(p);
end

if G.pop_wise == 0
	F(:, :) = G.f(x);
else
	for p = 1 : G.P
   		F(p, :) = G.f(x, p);
	end
end

for p = 1 : G.P
    F_mean(p) = F(p, :) * x_n(p, :)';

    % calculate update in the strategy
    F_excess = F(p, :) - ones(1, n) * F_mean(p);
    x_dot_v ( (p-1)*n + 1 : p*n ) = F_excess .* x_n(p, :) / F_mean(p);
end

dz = [x_dot_v];
if G.stop_c == true
    norm_dx = norm(dz);
end
