% graph average behavior of the dynamics




figure(15)
clf
lim_ = abs(max(U_avg_s) - min(U_avg_s));
subplot(2,1,1)
%subplot('Position',  [0.1 0.1 0.5 0.5] )
plot(T,U_avg, 'g--','LineWidth',2)
hold on
plot(T,U_avg_rd, '--')
plot(T,U_avg_s, 'k')
plot(T, U_avg_bnn, 'r-.')


title('Society`s Surplus')
ylim([min(U_avg_s)-lim_*.1 max(U_avg_s)+lim_*.2])
xlim([T(1) T(end)])
ylabel('Social Surplus')
xlabel('Time')


h = legend( 'Logit Dynamics', 'Replicator Dynamics', 'Smith Dynamics', 'BNN Dynamics',4);
set(h,'Interpreter','none')


set(gca, 'XScale', 'log')





lim_ = abs(max(P_avg_s) - min(P_avg_s));
subplot(2,1,2)
%axes('Position',[0.1 0.1 0.5 0.5])
pd = plot(T,P_avg, 'g--','LineWidth',2);
hold on
pb=plot(T,P_avg_rd, '--');
pa=plot(T,P_avg_s, 'k');
pc = plot(T, P_avg_bnn, 'r-.');
hold off

title('Electricity Demand')
ylim([min(P_avg_s)-lim_*.1 max(P_avg_s)+lim_*.2])
ylabel('Power Comsumption')
%h = legend( 'Logit Dynamics', 'Replicator Dynamics', 'Smith Dynamics', 'BNN Dynamics',1);
%set(h,'Interpreter','none')
xlabel('Time')
xlim([T(1) T(end)])


set(gca, 'XScale', 'log')





%lh = legend([pa,pb,pc, pd],{ 'Logit Dynamics', 'Replicator Dynamics', 'Smith Dynamics', 'BNN Dynamics'}); %, 'Logit Dynamics'
%gridLegend([pa,pb,pc, pd],4,'location','southoutside');
%legend('boxoff')




figure(16)

lim_ = abs(max(I_avg_s) - min(I_avg_s));
%subplot(3,1,3)
p4 = plot(T,I_avg, 'g--','LineWidth',2);
hold on
p2 = plot(T,I_avg_rd, '--');
p1 = plot(T,I_avg_s, 'k');
p3 = plot(T,I_avg_bnn, 'r-.');

hold off
%plot([2 2],[min(I_avg)-lim_*.1 max(I_avg)+lim_*.2], 'k--')
%plot(4*[1 1],[min(I_avg)-lim_*.1 max(I_avg)+lim_*.2], 'k--')
%hold off
%title('Average Incentives')
%ylim([min(I_avg_s)-lim_*.1 max(I_avg_s)+lim_*.1])
ylabel('Incentives')
xlabel('Time')
h = legend( 'Logit Dynamics', 'Replicator Dynamics', 'Smith Dynamics', 'BNN Dynamics',1);
set(h,'Interpreter','none')
title('Average Incentives of the Society')
%set(h, 'FontSize', 20)
xlim([T(1) T(end)])


set(gca, 'XScale', 'log')




%sh = subplot(7,1,7)
%p = get(sh, 'position')
%lh = legend([p1,p2,p3,p4],{'Smith Dynamics','Replicator Dynamics ', 'BNN Dynamics ', 'Logit Dynamics'}); %
%gridLegend([p1,p2,p3,p4],4,'location','north');
%legend('boxoff')
%set(lh, 'position', p)
%axis(sh, 'off')

%newPosition = [0.4 0.4 0.2 0.2];
%newUnits = 'normalized';
%set(lh,'Position', newPosition,'Units', newUnits);


%print -deps2 './evolution_dynamics_attack.eps'

%set(gca, 'XTickLabel', [],'XTick',[])

%set(gca, 'LooseInset', get(gca,'TightInset'))








%%% integration calculation
int_smith = zeros(1,length(T));
int_replicator = zeros(1,length(T));
int_bnn = zeros(1,length(T));
int_logit = zeros(1,length(T));
int_avg = zeros(1,length(T));

int_smith(1) = I_avg_s(1) * T_ * G.step + G.step;
int_replicator(1) = I_avg_rd(1) * T_ * G.step + G.step;
int_bnn(1) = I_avg_bnn(1) * T_ * G.step + G.step;
int_logit(1) = I_avg(1) * T_ * G.step + G.step;
%int_avg(1) = (int_smith(1) + int_replicator(1) + int_bnn(1) + int_logit(1))/4;
int_avg(1) = int_smith(1);

for i=2:length(T)
    int_smith(i) = int_smith(i-1) +  I_avg_s(i) * T_ * G.step;
    int_replicator(i) = int_replicator(i-1) + I_avg_rd(i) * T_ * G.step;
    int_bnn(i) = int_bnn(i-1) + I_avg_bnn(i) * T_ * G.step;
    int_logit(i) = int_logit(i-1) + I_avg(i) * T_ * G.step;
    int_avg(i) = (int_smith(i) + int_replicator(i) + int_bnn(i) + int_logit(i))/4;
    %int_avg(i) = int_smith(i);
end










figure(20)
clf
p4=plot(T, int_logit./int_avg, 'g--','LineWidth',2);
hold on
p2=plot(T, int_replicator./int_avg, '--');
p1=plot(T, int_smith./int_avg, 'k');


p3=plot(T, int_bnn./int_avg, 'r-.');

hold off

xlim([T(1) T(end)])
%ylim([-.2 1.1])
title('Integrate Along the Time of the Incentives')
%ylim([min(I_avg_s)-lim_*.1 max(I_avg_s)+lim_*.2])
ylabel('Accumulated Incentives')
xlabel('Time')
h = legend( 'Logit Dynamics', 'Replicator Dynamics', 'Smith Dynamics', 'BNN Dynamics',4);
set(h,'Interpreter','none')




set(gca, 'XScale', 'log')
%set(gca, 'YScale', 'log')


%lh = legend([p1,p2,p3,p4],{'Smith Dynamics','Replicator Dynamics ', 'BNN Dynamics ', 'Logit Dynamics'}); %
%gridLegend([p1,p2,p3,p4],2,'location','northoutside');









