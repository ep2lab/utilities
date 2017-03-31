%{
Converts the ticklabels of an axis of the given axes object into power
10 numbers, assuming that existing labels are the exponent.
The output is formatted in latex

INPUTS: 
* ha: axes handle or colorbar handle
* XYZ: a character 'X', 'Y' or 'Z' denoting the axis to treat (only
  needed if ha is an axes handle)

OUTPUT:
* ha: the handle again

%----------------------------------------------------------------------
Author: Mario Merino
Date: 20121024
%----------------------------------------------------------------------
%}
function ha = set_ticklabels_in_power_10(ha,XYZ)

if isa(ha,'matlab.graphics.illustration.ColorBar')
    str_Ticks = 'Ticks';
    str_TickLabels = 'TickLabels';
    str_TickLabelInterpreter = 'TickLabelInterpreter';
else
    str_Ticks = [XYZ,'Tick'];
    str_TickLabels = [XYZ,'TickLabel'];
    str_TickLabelInterpreter = [XYZ,'TickLabelInterpreter'];
end
ticks = get(ha,str_Ticks);
labels = cell(length(ticks),1);
for i=1:length(ticks)
    tick = ticks(i);
    if tick == 0
        label = '$1$';
    elseif tick == 1
        label = '$10$';
    else
        label = ['$10^{',num2str(tick),'}$'];
    end
    labels{i} = label;
end
set(ha,str_TickLabels,labels,str_TickLabelInterpreter,'latex');    

