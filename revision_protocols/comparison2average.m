function s_i = comparison2average(F, z, s, i, p)

	global G

    j = unidrnd( G.S(p) );

    %pi_i = F( s(i) );
    pi_j = F( j );

    rho_ij = max(pi_j - F' * z / G.m, 0);


    % prob generator
    change = ceil(rand - 1 + rho_ij / G.R);
    
    if change == 1
        s_i = j;
	else
		s_i = s(i);
    end

