function dz = logit(t,z)
% LOGIT Computes the differential equation that describes the update of the 
%       populations' state following the logit dynamics
% 
% SYNOPSIS: DZ = LOGIT(T, Z)
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
% SEE ALSO definition, bnn, rd, maynard_rd, smith, smith_b, stopevent, combined_dynamics
%
% For more information see: <a href="https://github.com/carlobar/PDToolbox_matlab/">the GitHub's repository.</a>
% 
% Carlos Barreto, 04-11-16 

global G norm_dx

eta = G.eta;

% extract matrix of strategies
n = max(G.S);
x_n = vec2mat(z,n);
x = zeros(G.P, n);

for p = 1 : G.P
    x(p, :) = x_n(p, :) * G.m(p);
end

% calculate fitness of each strategy
F = zeros(G.P, n);
F_ = zeros(G.P, n);
F_mean = zeros(G.P, 1);
x_dot_v = zeros(G.P* n, 1);

if G.pop_wise == 0
	F(:, :) = G.f(x);
else
	for p = 1 : G.P
   		F(p, :) = G.f(x, p);
	end
end

for p = 1 : G.P
    F_(p, :) = exp( F(p, : ) / eta );
    F_mean(p) = F_(p, :) * ones(n, 1);

% calculate update in the strategy
    x_dot_v( (p-1)*n + 1 : p*n) = F_(p, :) / F_mean(p) - x_n(p, :);
end

dz = [x_dot_v];
if G.stop_c == true
    norm_dx = norm(dz);
end

