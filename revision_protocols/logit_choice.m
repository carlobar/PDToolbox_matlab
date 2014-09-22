function s_i = logit_choice(F, z, s, i, p)

	global G

    j = unidrnd( G.S(p) );


	eta = G.eta;
    F_ = exp( F(1:G.S(p) ) / eta );
    F_mean = sum(F_(:));



%    pi_i = F( s(i) );
%    pi_j = F( s(j) );




    rho_ij =  F_(j) / F_mean;

    % prob generator
    change = ceil(rand - 1 + rho_ij / G.R);
    
    if change == 1
        s_i = j;
	else
		s_i = s(i);
    end

if j == 3
    h=1;
end