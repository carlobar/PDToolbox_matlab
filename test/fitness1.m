function f_i = fitness(x, p, s)

%This fitness function corresponds to a rock-paper-scisors game
 A = [ 0 -1  1;...
	   1  0 -1;...
      -1  1  0];

 f_i = A(s, :) * x' ;
