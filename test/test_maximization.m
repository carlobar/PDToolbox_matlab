% example of a maximization problem.

% population games tool box
clear

global G

% number of populations
P = 1;

% number of pure strategies per population
n = 3;

% mass of the population
m = [10; 10];

% initial condition
x0 = [0.1 .8 0.1 ]'; 

% simulation parameters
time = .4;

fitness_f = @(x,p) - [2*(x(1) - 5); 2*(x(2) - 5); 0];

% structure with the parameters of the game
G = struct('P', P, 'n', n, 'm', m, 'f', fitness_f, 'x0', x0, 'ode', 'ode113', 'time', time);

% verify data of the game
G = definition(G);

G.dynamics = {'smith'};
G.run()
G.graph()
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
plot(G.X(:,1)*m(1), G.X(:,2)*m(2), 'k')





