function [x,isterm,dir] = stopevent(t, y)

global norm_dx c_error

x = norm_dx - c_error;
isterm = 1;
dir = 0;
