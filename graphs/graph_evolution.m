%
%function z = graph_evolution(p)

%global G




%if ((p <= 0) | (p > G.P))
%    exit('Argument not valid');
%end




cc=hsv(max(G.S));
n = max(G.S);

figure(2)
clf 
for p = 1 : G.P
    subplot(G.P, 1 ,p);
    hold on
    
    for s = 1 : G.S(p)
        plot(G.T, G.X(:, (p-1)*n + s), 'color', cc(s, :));
    end
    ylim([0 1])
    hold off
    
end




%plot(T,X(:,1)); hold on; plot(T,X(:,2),'r');plot(T,X(:,3),'g')
