% graph utility

cc=hsv(max(G.S));
n = max(G.S);

figure(5)
clf 
for p = 1 : G.P

	utility = zeros( length(G.T), G.S(p) );
	utility_mean = zeros( length(G.T), 1 );
	for t = 1: length(G.T)
		%for i = 1 : G.S(p)
		%	utility(t, i) =  G.f(G.X(t, (p-1)*n + 1 : G.S(p) ), p, i);
		%end
        utility(t, :) =  G.f(G.X(t, (p-1)*n + 1 : G.S(p) ), p);
		utility_mean(t) = utility(t, :) * G.X(t, (p-1)*n + 1 : G.S(p) )';
	end


    subplot(G.P, 1 ,p);
    hold on
    labels = cellstr('');
    for s = 1 : G.S(p)
        plot(G.T, utility(:, s), 'color', cc(s, :));
		plot(G.T, utility_mean, 'k');
	labels(s) = cellstr([num2str(s), '-th strategy']);
    end
    %ylim([0 1])
    xlim([0 G.time])
    hold off

    title_i = ['Utility of the ', num2str(p), '-th Population'];
    title(title_i)

    h = legend(labels);
    set(h, 'Interpreter', 'none')    
    xlabel('time')
end


