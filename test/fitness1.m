function f_i = fitness1(x, p)

%This fitness function corresponds to a rock-paper-scissors game
A = [ 0 -1  1;...
      1  0 -1;...
     -1  1  0];

% we add a constant calue to obtain positive payoffs
A = A + 2;

f_i = A * x' ;
