function dz = heuristic_combined_dynamics(t,z)

global G beta_ef N T_ hybrid
n = max(G.S);
dz = zeros(G.P * n, 1);
dz_i = zeros(G.P * n, 1);

% state of the system
x_n = vec2mat(z,n);
x = zeros(G.P, n);
for p = 1 : G.P
    x(p, :) = x_n(p, :) * G.m(p);
end


A = 2* beta_ef * ones(N,1) * ones(1,N) *(-1/(N-1)) + eye(N)*N/(N-1);


Inc_change = zeros(length(G.dynamics), 1);


for k = 1 : length(G.dynamics)
	command = strcat( G.dynamics{k}, '(t,z)');
	dz_k = eval( command );

	dz_n = vec2mat(dz_k, n);

	for t_ = 1: T_
		Inc_change(k) = Inc_change(k) + 2 * beta_ef * x(:,t_)' * A * dz_n(:,t_);
	end

end

[B C] = sort(Inc_change);


command = strcat( G.dynamics{C(1)}, '(t,z)');

dz = eval( command );

hybrid (floor(t/.01)) = C(1);
