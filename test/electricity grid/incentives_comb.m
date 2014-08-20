% calculate utility over time

global hybrid

hybrid = zeros(time/.01+1, 1);

G.dynamics = {'rd', 'bnn', 'smith', 'logit'};
G.gamma = [1 1 1 1];
G.run()

T = G.T;
X = G.X;

n = T_ + 1;

U_avg_c = zeros(1,length(T));
F_avg_c = zeros(1,length(T));
I_avg_c = zeros(1,length(T));
P_avg_c = zeros(1,length(T));



for t = 1:length(T)

x = X(t,:)';
x_ = vec2mat(x,n);

power = x_*mp;

F = zeros(N,T_+1);
U = zeros(N,T_+1);
inc = zeros(N,T_);

% calculate the fitness and incentives of the system at t
for index=1:N
%summ = sum(x_(i,:));
%if (summ ~= mp)
%    t
%end
    for l=1:T_
        q_t = power(index,l);
        sum_q = sum(power(:,l));
        price = p_x(power,l);
        
        sum_q_i = sum(power(:,l)) - q_t;
        
        val = v_x(q_t,index,l);

%        if (T(t) < time_on) || (T(t) > time_off)
%            F(index,l) = alpha_ef(index,l)/(1+q_t) - beta_ef*(sum_q+q_t);
%            inc(index,l) = 0*sum_q_i*( - price + h_i(sum_q_i) );
%        else
            F(index,l) = alpha_ef(index,l)/(1+q_t) - 2*beta_ef*(sum_q) ;            
            inc(index,l) = sum_q_i*( - price + h_i(sum_q_i) );
%        end
        
        
        U(index,l) = val - q_t*price + inc(index,l);

    end
    F(:, T_ + 1) = max(F(:,1:T_),[], 2)*0;

end

%sum(power,2)

U_avg_c(t) = sum(sum(U(:,1:T_), 2)/T_);
F_avg_c(t) = sum(sum(F(:,1:T_), 2)/T_);
I_avg_c(t) = sum(sum(inc,2)/T_);
P_avg_c(t) = sum(sum(power(:,1:T_),2)/T_);



end





graph_ev_dynamics



figure(15)
subplot(2,1,1)
hold on
plot(T, U_avg_c, 'm--')
hold off

subplot(2,1,2)
hold on
plot(T,P_avg_c, 'm--');
hold off




figure(16)
hold on
plot(T,I_avg_c, 'm--');
hold off



%%% integration calculation
int_c = zeros(1,length(T));

int_c(1) = I_avg_c(1) * T_ * G.step + G.step;


for i=2:length(T)
    int_c(i) = int_c(i-1) +  I_avg_c(i) * T_ * G.step;
end

figure(20)
hold on
plot(T, int_c./int_avg, 'm--');
hold off

set(gca, 'XScale', 'log')






figure(21); plot(G.T, hybrid)
