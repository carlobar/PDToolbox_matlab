%
function z = graph_evolution(p)

global G

if ((p <= 0) | (p > G.P))
    exit('Argument not valid');
end

cc=hsv(max(G.S));
n = max(G.S);
figure(11)
clf 
hold on

for s = 1 : G.S(p)
    plot(G.T, G.X(:, (p-1)*n + s), 'color', cc((p-1)*n +  s, :))
end
hold off
%plot(T,X(:,1)); hold on; plot(T,X(:,2),'r');plot(T,X(:,3),'g')