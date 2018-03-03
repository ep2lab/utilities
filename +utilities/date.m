%{
Returns current date as a string without unnecessary symbols
 
INPUT:

OUTPUT:
* date: current date string, like 20170824 

%----------------------------------------------------------------------
Author: Mario Merino
Date: 20170824
%----------------------------------------------------------------------
%}
function date = date
t = fix(clock); % gets current time array
date = [num2str(t(1)), num2str(t(2),'%02i'), num2str(t(3),'%02i')]; 
