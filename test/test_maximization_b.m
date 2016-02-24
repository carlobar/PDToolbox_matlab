% example of a maximization problem.

clear

% number of populations
P = 2;

% number of pure strategies per population
n = 2;

% mass of the population
m = [10; 10];

% initial condition
x0 = [0.1 .9; ...
      0.8 0.2]'; 

% simulation parameters
time = 20;

fitness_f = @(x,p) - [2*(x(p,1) - 5); 0] ;

% structure with the parameters of the game
G = struct('P', P, 'n', n, 'm', m, 'f', fitness_f, 'x0', x0, 'ode', 'ode113', 'time', time, 'stop_c', true);

% verify data of the game
G = definition(G);

G.dynamics = {'smith'};
G.run()
G.graph2p()
G.graph_evolution()


% plot the evolution of the strategies
% objective function
f = @(x) -((x(1) - 5)^2 + (x(2) - 5)^2);

% 
z = 0:0.1:10;
M = zeros(length(z), length(z));
for i=1:length(z)
    for j=1:length(z)
        M(i,j) = f([z(i); z(j)]);
    end
end

figure(3)
clf
contour(z,z,M)
hold on
plot(5,5,'ok')
plot(G.X(:,1)*m(1), G.X(:,3)*m(2), 'k')





