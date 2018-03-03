%{
Provides the nodes and weights for a Gauss-Laguerre quadrature to
integrate functions of the kind of exp(-x)*f(x)*dx from a to Inf.
To integrate: 
    Integral = sum(w.*f(x+a))*exp(-a)

INPUT   
* n: order of quadrature

OUTPUT
* x: roots of Laguerre polynomial of order n, which give the integration nodes  
* w: corresponding weights for the quadrature

%----------------------------------------------------------------------
Author: Mario Merino
Date: 20171206
%----------------------------------------------------------------------
%}
function [x,w] = gausslaguerre(n)

%% Prepare Gauss-Laguerre integration nodes and weights
temp  = diag(1:n-1,-1) + diag(2*(1:n)-1) + diag(1:n-1,1);
[V, D]   = eig(temp);
[x,order] = sort(diag(D)); 
V = V(:,order); 
w = V(1,:).^2;
w = w(:); % force column
