%{
Returns the parametric representation of the intersection line between
two planes. If the planes are parallel, return NaNs.

INPUT:
* P1, P2: planes to interect, given by vectors in the form [a,b,c,d],
  where each plane is a*x + b*y + c*z + d = 0

OUTPUT:
* R0: 3-vector with point of the line closet to the origin
* R1: 3-vector with the unit vector of the line

%----------------------------------------------------------------------
Author: Mario Merino
Date: 20171002
%----------------------------------------------------------------------
%}
function [R0,R1] = intersection_of_two_planes(P1,P2)

% Force column
P1 = P1(:); 
P2 = P2(:); 

% Compute unit vector of line
R1 = cross(P1(1:3),P2(1:3));
nR1 = norm(R1);
if nR1 == 0 % The two planes are parallel
    R1 = [1;1;1]*NaN;
    R0 = [1;1;1]*NaN;
    return;
end
R1 = R1/nR1;

% Compute nearest point of line to origin
A = [P1(1:3).';
     P2(1:3).';
     R1.'];
R0 = A\[P1(4);P2(4);0]; 

