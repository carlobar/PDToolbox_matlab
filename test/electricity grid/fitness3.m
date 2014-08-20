function f_i = fitness3(x, p, s)

global beta_ef alpha_ef time_on time_off mp

power = x * mp;

index = p;
l = s;

if l <= 24
    q_t = power(index, l);
    sum_q = sum( power(:, l) );
    alpha = alpha_ef(index,l);
    f_i = alpha/(1+q_t) - 2 * beta_ef*(sum_q) ;
else
    f_i = 0;
end

