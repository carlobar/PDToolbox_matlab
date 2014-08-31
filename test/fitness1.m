function f_i = fitness(x, p, s)

%This fitness function corresponds to a rock-paper-scissors game
 A = [ 0 -1  1;...
	   1  0 -1;...
      -1  1  0];

A = A + 2;

 f_i = A(s, :) * x' ;
