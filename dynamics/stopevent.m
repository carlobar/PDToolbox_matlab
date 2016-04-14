function [x, isterm, dir] = stopevent(t, y)
% STOPEVENT Event used to stop the ODE solver when the norm of the game's
%           differential equation is smaller than C_ERROR
% 
% SYNOPSIS: [X, ISTERM, DIR] = STOPEVENT(T, Y)
% 
% INPUT T: Time
%       Y: State
% 
% OUTPUT X: Vector of events. When X(i) reaches zero, the i-th event is 
%           triggered
%        ISTERM: If equal to 1, then stops the solver with the first event.
%                If equal to 0, then stops when all events are triggered
%        DIR: (1) trigger events when X(i) is increasing; (-1) trigger events 
%             when X(i) is decreasing; (0) trigger all crosses through zero
%
% SEE ALSO definition, bnn, logit, rd, maynard_rd, smith, smith_b, combined_dynamics
%
% For more information see: <a href="https://github.com/carlobar/PDToolbox_matlab/">the GitHub's repository.</a>
% 
% Carlos Barreto, 04-11-16 

global norm_dx c_error

x = norm_dx - c_error;
isterm = 1;
dir = 0;
