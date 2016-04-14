function graph_final_state(G)

cc=hsv(G.P);
n = max(G.S);
figure(3)
clf 
hold on

x = vec2mat(G.X(end, :), max(G.S));

for p = 1 : P
    plot(1 : 1 : G.S(p)-1, x(p, 1:24), 'color', cc(p, :))
end

hold off

title('Final State of the Society')
