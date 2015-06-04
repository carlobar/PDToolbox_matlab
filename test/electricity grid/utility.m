function U = utility(x)

global N T_ beta_ef alpha_ef

power = x;

F = zeros(N,T_+1);
U = zeros(N,T_+1);
%inc = zeros(N,T_);

% calculate the utility
for index=1:N
    for l=1:T_
        q_t = power(index,l);
        sum_q = sum(power(:,l));
        price = p_x(power,l);
        %sum_q_i = sum(power(:,l)) - q_t;
        
        val = v_x(q_t,index,l);
        %F(index,l) = alpha_ef(index,l)/(1+q_t) - 2*beta_ef*(sum_q) ;            
        %inc(index,l) = sum_q_i*( - price + h_i(sum_q_i) );
        
        U(index,l) = val - q_t*price;% + inc(index,l);

    end
end

