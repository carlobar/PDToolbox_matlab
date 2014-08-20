function c = p_x(x,t)

global beta_ef

x_total = sum(x(:,t));

c = beta_ef*(x_total);

