%{
Produces a mesh-grid like set of bidimensional arrays XX,YY,ZZ that mesh
an inclined plane, given by:

  r= o + v1*t1 + v2*t2, where r, o,v1,v2 are vectors.

INPUT:
* o: 3-vector of an origin point in the plane
* v1, v2: linearly-independent tangent vectors in the plane
* t1Lim,t2Lim: the limits for the meshgrid in the parameters t1,t2
* t1points,t2points: number of points in each parametric direction

OUTPUT:
* XX,YY,ZZ: 2D arrays with the coordenates of the grid of the plane

%----------------------------------------------------------------------
Author: Mario Merino
Date: 20170314
%----------------------------------------------------------------------
%}
function [XX,YY,ZZ] = meshgrid_inclined_plane(o,v1,v2,t1Lim,t2Lim,t1points,t2points)

%% Obtain parametric grid
[T1,T2] = meshgrid(linspace(t1Lim(1),t1Lim(2),t1points),linspace(t2Lim(1),t2Lim(2),t2points));

%% Plane grid according to definition
XX = o(1)+v1(1)*T1+v2(1)*T2;
YY = o(2)+v1(2)*T1+v2(2)*T2;
ZZ = o(3)+v1(3)*T1+v2(3)*T2;

