%{
Returns current time as a string without unnecessary symbols
 
INPUT:

OUTPUT: 
* time: current time string, like 153710

%----------------------------------------------------------------------
Author: Mario Merino
Date: 20170824
%----------------------------------------------------------------------
%}
function time = time
t = fix(clock); % gets current time array 
time = [num2str(t(4),'%02i'), num2str(t(5),'%02i'), num2str(t(6),'%02i')];
