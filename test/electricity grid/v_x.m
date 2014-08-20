function v = v_x(q,i,t)

global alpha_ef alpha_mean


v = alpha_ef(i,t)  * log(1+q);
