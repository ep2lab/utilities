%{
Quick interpolation indices in 1D. The library grid must be perfectly
Cartesian and equispaced.

Values inside/outside of the library are marked in o.

INPUT:
* X: 1-vector with library X
* x: array with interpolation points

OUTPUT:
* l,h,s: indices of interpolation. l is the lower index, h is the upper
  index, s is the fraction distance to the lower index
* i: logical array that can be used for indicing, that is true only for
  those x inside the library domain.

%----------------------------------------------------------------------
Author: Mario Merino
Date: 20170314
%----------------------------------------------------------------------
%}
function [l,h,s,i] = qinterpi(X,x)

%% Value of x in index space 
s = (x-X(1))/(X(2)-X(1)) + 1;

%% Prepare output
l = floor(s); 
h = ceil(s); 
s = s - l;
if nargout == 4
    i = x>=X(1) & x<=X(end);
end 
