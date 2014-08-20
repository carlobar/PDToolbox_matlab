% graph dynamics of the system for the smith dynamics and the replicator
% dynamics


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% smith dynamics
T = T_smith;
n = T_ + 1;

U_avg = zeros(1,length(T));
F_avg = zeros(1,length(T));
I_avg = zeros(1,length(T));
P_avg = zeros(1,length(T));



for t = 1:length(T)

x = X_smith(t,:)';
x_ = vec2mat(x,n);

power = x_*mp;

F = zeros(N,T_+1);
U = zeros(N,T_+1);
inc = zeros(N,T_);

% calculate the fitness and incentives of the system at t
for index=1:N

    for l=1:T_
        q_t = power(index,l);
        sum_q = sum(power(:,l));
        price = p_x(power,l);
        
        sum_q_i = sum(power(:,l)) - q_t;
        
        val = v_x(q_t,index,l);

%        if (T(t) <= time_on) || (T(t) >= time_off)
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

U_avg(t) = sum(sum(U(:,1:T_), 2)/T_);
F_avg(t) = sum(sum(F(:,1:T_), 2)/T_);
I_avg(t) = sum(sum(inc, 2)/T_);
P_avg(t) = sum(sum(power(:,1:T_),2)/T_);



end

U_avg_s = U_avg;
F_avg_s = F_avg;
I_avg_s = I_avg;
P_avg_s = P_avg;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
%%% analysis for replicator equation
T = T_rd;
n = T_ + 1;

U_avg = zeros(1,length(T));
F_avg = zeros(1,length(T));
I_avg = zeros(1,length(T));
P_avg = zeros(1,length(T));



for t = 1:length(T)

x = X_rd(t,:)';
x_ = vec2mat(x,n);

power = x_*mp;

F = zeros(N,T_+1);
U = zeros(N,T_+1);
inc = zeros(N,T_);

% calculate the fitness and incentives of the system at t
for index=1:N

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

U_avg(t) = sum(sum(U(:,1:T_), 2)/T_);
F_avg(t) = sum(sum(F(:,1:T_), 2)/T_);
I_avg(t) = sum(sum(inc,2)/T_);
P_avg(t) = sum(sum(power(:,1:T_),2)/T_);



end

%sum(power,2)

U_avg_rd = U_avg;
F_avg_rd = F_avg;
I_avg_rd = I_avg;
P_avg_rd = P_avg;





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
%%% analysis for bnn
T = T_bnn;
n = T_ + 1;

U_avg = zeros(1,length(T));
F_avg = zeros(1,length(T));
I_avg = zeros(1,length(T));
P_avg = zeros(1,length(T));



for t = 1:length(T)

x = X_bnn(t,:)';
x_ = vec2mat(x,n);

power = x_*mp;

F = zeros(N,T_+1);
U = zeros(N,T_+1);
inc = zeros(N,T_);

% calculate the fitness and incentives of the system at t
for index=1:N

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

U_avg(t) = sum(sum(U(:,1:T_), 2)/T_);
F_avg(t) = sum(sum(F(:,1:T_), 2)/T_);
I_avg(t) = sum(sum(inc,2)/T_);
P_avg(t) = sum(sum(power(:,1:T_),2)/T_);



end

%sum(power,2);

U_avg_bnn = U_avg;
F_avg_bnn = F_avg;
I_avg_bnn = I_avg;
P_avg_bnn = P_avg;





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
%%% analysis for logit
T = T_logit;
n = T_ + 1;

U_avg = zeros(1,length(T));
F_avg = zeros(1,length(T));
I_avg = zeros(1,length(T));
P_avg = zeros(1,length(T));



for t = 1:length(T_logit)

x = X_logit(t,:)';
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

U_avg(t) = sum(sum(U(:,1:T_), 2)/T_);
F_avg(t) = sum(sum(F(:,1:T_), 2)/T_);
I_avg(t) = sum(sum(inc,2)/T_);
P_avg(t) = sum(sum(power(:,1:T_),2)/T_);



end






% graph the evolution of the dynamics
graph_ev_dynamics




