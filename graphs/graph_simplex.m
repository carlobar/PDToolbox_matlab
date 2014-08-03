
figure(1)
clf
hold on
plot3([0 1 0 0]', [1 0 0 1]', [0 0 1 0]', 'k')
plot3(X(:,1), X(:,2), X(:,3)); 
axis([0 1 0 1 0 1]); 
view(135,0)
hold off



