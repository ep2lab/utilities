%{
Standard Newton-Raphson solver for systems of equations f = 0. 
 
INPUT:
* f: the function to be zeroed. Has a single argument (a column vector of
dimension n) and returns a single output (a column vector of dimension n)  
* df: function for the Jacobian matrix of f. Takes a single argument (a column
  vector of dimension n) and returns a single output (a nxn matrix). Must
  be ordered so that df_ij = d fi / d xj
* x: The initial guess 
* tol (optional): tolerance 
* n_iter (optional): max number of iterations 

OUTPUT:
* x: If converged, a solution to f(x) = 0
* fx: The value of the function at the output x
* i: The number of iterations used

%----------------------------------------------------------------------
Author: Mario Merino
Date: 20120510
%----------------------------------------------------------------------
%}
function [x,fx,i] = newton(f,df,x,tol,n_iter)

if ~exist('tol','var')
        tol= 1e-6; % default value
end
if ~exist('nmax','var')
    n_iter = 100; % default value
end

fx = f(x); 
for i = 1:n_iter
    dx = - df(x)\fx;
    x = x + dx;        
    fx = f(x); 
    if norm(fx) < tol && ((norm(x) < tol && norm(dx) < tol) || norm(dx)/norm(x) < tol) % avoids problems for x near 0
        if i>5; i; end;
        return;
    end
end    
error('newton: reached n_iter iterations without convergence');
