function dz = smith_b(t,z)

global G norm_dx

% extract matrix of strategies
n = max(G.S);
x_n = vec2mat(z, n);
x = zeros(G.P, n);

F = zeros(G.P, n);
F_excess_a = zeros(1,n);
F_excess_b = zeros(1,n);
x_dot_v = zeros(G.P* n, 1);

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
    % order the strategies by their fitness
    [A, B] = sort( F( p, 1:G.S(p) ) );

    A_sum = A(1:n)*ones(n,1);
    A_avg = 0;
    x_ordered = x_n(p, B)';
    x_cum = 0;
    for i=1:G.S(p)
       k = B(i);
       A_sum = A_sum-A(i); 
       
       F_excess_a(k) =  A(i)*x_cum - A_avg;       
       F_excess_b(k) = A_sum - A(i)*(n-i);

        A_avg = A_avg + A(i)*x_ordered(i);
        x_cum = x_cum + x_ordered(i);
    end

    % calculate update in the strategy
    x_dot_v( (p-1)*n + 1 : p*n) = F_excess_a - F_excess_b .* x_n(p, :);
end


dz = [x_dot_v];

if G.stop_c == true
    norm_dx = norm(dz);
end
