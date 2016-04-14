function dz = smith(t,z)

global G

% extract matrix of strategies
n = max(G.S);
x_n = vec2mat(z, n);
x = zeros(G.P, n);

F = zeros(n,1);
%F_excess_a = zeros(1,n);
%F_excess_b = zeros(1,n);
x_ordered = zeros(n,1);
x_dot_v = zeros(G.P* n, 1);

for p = 1 : G.P
    x(p, :) = x_n(p, :) * G.m(p);
end


for p = 1 : G.P
    F = G.f(x, p) ;
%end
    
%for p = 1 : G.P
    % order the strategies by their fitness
    [A, B] = sort( F( 1:G.S(p) ) );

    A_sum = A(1:n)'*ones(n,1);
    A_avg = 0;
    x_ordered = x_n(p, B)';
    x_cum = 0;
    A_rel = A .* x_ordered;
    for i=1:G.S(p)
       k = B(i);
       A_sum = A_sum-A(i); 
       
       % F_excess_a(k) =  A(i)*x_cum - A_avg;       
       % F_excess_b(k) = A_sum - A(i)*(n-i);

	x_dot_v( (p-1)*n + k ) = A(i) * x_cum - A_avg - x_ordered(i)*A_sum + A_rel(i)*(n-i);	

        A_avg = A_avg + A_rel(i);
        x_cum = x_cum + x_ordered(i);



    end

    % calculate update in the strategy
    %x_dot_v( (p-1)*n + 1 : p*n) = F_excess_a - F_excess_b .* x_n(p, :);
end

dz = [x_dot_v];

