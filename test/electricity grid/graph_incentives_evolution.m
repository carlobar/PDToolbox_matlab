% graph dynamics of the system for the smith dynamics and the replicator
% dynamics

valuation = @(q_i, i, t) alpha_ef(i,t)  * log(1+q_i);
price = @(q) beta_ef * q .^ 2 + b*q;
h_f =@(q_i) price( q_i * N/(N-1) );


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% smith dynamics
T = T_smith;
X = X_smith;
n = T_ + 1;

U_avg_s = zeros(1,length(T));
I_avg_s = zeros(1,length(T));
P_avg_s = zeros(1,length(T));


for t = 1:length(T)

x = X(t,:)';
x_ = vec2mat(x,n);

power = x_*mp;

U = zeros(N,T_+1);
inc = zeros(N,T_);

total_q = ones(1, P) * power;
p = price(total_q);

% calculate the fitness and incentives of the system at t
for index=1:N
    for l=1:T_
        q_t = power(index,l);
        sum_q = total_q(l);
        sum_q_i = sum_q - q_t;
        val = valuation(q_t,index,l);
           
        inc(index,l) = sum_q_i * ( - p(l) + h_f( sum_q_i ) );
        
        U(index,l) = val - q_t*p(l);% + inc(index,l);

    end
end

U_avg_s(t) = sum(sum(U(:,1:T_), 2)/T_);
I_avg_s(t) = sum(sum(inc, 2)/T_);
P_avg_s(t) = sum(sum(power(:,1:T_),2)/T_);
end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% rd dynamics
T = T_rd;
X = X_rd;
n = T_ + 1;

U_avg_rd = zeros(1,length(T));
I_avg_rd = zeros(1,length(T));
P_avg_rd = zeros(1,length(T));


for t = 1:length(T)

x = X(t,:)';
x_ = vec2mat(x,n);

power = x_*mp;

U = zeros(N,T_+1);
inc = zeros(N,T_);

total_q = ones(1, P) * power;
p = price(total_q);

% calculate the fitness and incentives of the system at t
for index=1:N
    for l=1:T_
        q_t = power(index,l);
        sum_q = total_q(l);
        sum_q_i = sum_q - q_t;
        val = valuation(q_t,index,l);
           
        inc(index,l) = sum_q_i * ( - p(l) + h_f( sum_q_i ) );
        
        U(index,l) = val - q_t*p(l);% + inc(index,l);

    end
end

U_avg_rd(t) = sum(sum(U(:,1:T_), 2)/T_);
I_avg_rd(t) = sum(sum(inc, 2)/T_);
P_avg_rd(t) = sum(sum(power(:,1:T_),2)/T_);
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% bnn dynamics
T = T_bnn;
X = X_bnn;
n = T_ + 1;

U_avg_bnn = zeros(1,length(T));
I_avg_bnn = zeros(1,length(T));
P_avg_bnn = zeros(1,length(T));


for t = 1:length(T)

x = X(t,:)';
x_ = vec2mat(x,n);

power = x_*mp;

U = zeros(N,T_+1);
inc = zeros(N,T_);

total_q = ones(1, P) * power;
p = price(total_q);

% calculate the fitness and incentives of the system at t
for index=1:N
    for l=1:T_
        q_t = power(index,l);
        sum_q = total_q(l);
        sum_q_i = sum_q - q_t;
        val = valuation(q_t,index,l);
           
        inc(index,l) = sum_q_i * ( - p(l) + h_f( sum_q_i ) );
        
        U(index,l) = val - q_t*p(l);% + inc(index,l);

    end
end

U_avg_bnn(t) = sum(sum(U(:,1:T_), 2)/T_);
I_avg_bnn(t) = sum(sum(inc, 2)/T_);
P_avg_bnn(t) = sum(sum(power(:,1:T_),2)/T_);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% smith dynamics
T = T_logit;
X = X_logit;
n = T_ + 1;

U_avg = zeros(1,length(T));
I_avg = zeros(1,length(T));
P_avg = zeros(1,length(T));


for t = 1:length(T)

x = X(t,:)';
x_ = vec2mat(x,n);

power = x_*mp;

U = zeros(N,T_+1);
inc = zeros(N,T_);

total_q = ones(1, P) * power;
p = price(total_q);

% calculate the fitness and incentives of the system at t
for index=1:N
    for l=1:T_
        q_t = power(index,l);
        sum_q = total_q(l);
        sum_q_i = sum_q - q_t;
        val = valuation(q_t,index,l);
           
        inc(index,l) = sum_q_i * ( - p(l) + h_f( sum_q_i ) );
        
        U(index,l) = val - q_t*p(l);% + inc(index,l);

    end
end

U_avg(t) = sum(sum(U(:,1:T_), 2)/T_);
I_avg(t) = sum(sum(inc, 2)/T_);
P_avg(t) = sum(sum(power(:,1:T_),2)/T_);
end








% graph the evolution of the dynamics
graph_ev_dynamics

