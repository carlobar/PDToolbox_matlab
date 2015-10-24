function graph_simplex(name)

% load the structure of the game that calls the function
G = evalin('base', name);

figure(1)
clf
hold on
plot3([0 1 0 0]', [1 0 0 1]', [0 0 1 0]', 'k')
plot3(G.X(:,1), G.X(:,2), G.X(:,3)); 
axis([0 1 0 1 0 1]); 
view(135,0)
hold off
title('Simplex')


