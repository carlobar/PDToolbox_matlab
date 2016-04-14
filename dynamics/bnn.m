function dz = bnn(t,z)
% BNN Computes the differential equation that describes the update of the 
%     populations' state following the Brown-von Neumann-Nash dynamics
% 
% SYNOPSIS: DZ = BNN(T, Z)
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
% SEE ALSO definition, logit, rd, maynard_rd, smith, smith_b, stopevent, combined_dynamics
%
% For more information see: <a href="https://github.com/carlobar/PDToolbox_matlab/">the GitHub's repository.</a>
% 
% Carlos Barreto, 04-11-16 


global G norm_dx

% extract matrix of strategies
n = max(G.S);
x_n = vec2mat(z,n);
x = zeros(G.P, n);

for p = 1 : G.P
    x(p, :) = x_n(p, :) * G.m(p);
end

F_mean = zeros(G.P, 1);
F = zeros(G.P, n);

F_excess = zeros(G.P, n);
F_gamma = zeros(G.P, 1);

x_dot_v = zeros(G.P* n, 1);

if G.pop_wise == 0
	F(:, :) = G.f(x);
else
	for p = 1 : G.P
   		F(p, :) = G.f(x, p);
	end
end

for p = 1 : G.P
    F_mean(p) = F(p, :) * x_n(p, :)';

    F_excess(p,:) = max( F(p, :) - F_mean(p), 0 );
    F_gamma(p) = F_excess(p, :) * ones(n, 1);

    x_dot_v( (p-1)*n + 1 : p*n ) = F_excess(p, :)  - F_gamma(p) * x_n(p, :);

end

dz = [x_dot_v];
if G.stop_c == true
    norm_dx = norm(dz);
end
