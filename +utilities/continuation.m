%{
Continuation of a branch defined implicitly by f(x) = 0 from point x0, where
f : R^n -> R^(n-1), and f(x0) = 0. The initial guess is first obtained by moving
a pseudo-arc-length ds from x0 along the tangent direction to the curve, and
then a Newton-Raphson method is used to find the new solution point.

Currently, the code is not prepared to deal with singular (i.e. branching) 
points, where the rank of df is not maximal.
 
INPUT:
* f: the function that defines the curve implicitly. Has a single argument (a
  column vector of dimension n) and returns a single output (a column vector of
  dimension n-1) 
* df: function for the Jacobian matrix of f. Takes a single argument (a column
  vector of dimension n) and returns a single output (a (n-1)x(n) matrix).
* x0: The previous point of the branch, which must satisfy f(x0)=0 (not checked)
* ds: the pseudo-arc-length coordinate to advance in this step
* tol (optional): tolerance for Newton-Raphson method
* n_iter (optional): max number of iterations for Newton-Raphson method

OUTPUT:
* x: the position of the new point in the branch

%----------------------------------------------------------------------
Author: Mario Merino
Date: 20170717
%----------------------------------------------------------------------
%}
function [x] = continuation(f,df,x0,ds,tol,n_iter)

%% Get dimension of space 
x0 = x0(:); % Make column vector
n = length(x0);

if ~exist('tol','var')
    tol = 1e-6;
end
if ~exist('n_iter','var')
    n_iter = 100;
end

%% Obtain the Jacobian matrix at x0, check if singular point
J0 = df(x0);
if rank(J0) < n-1
	error('Jacobian matrix is not full-rank');
end

%% Guess new point
t = null(J0); % already norm 1
t = t*sign(det([J0;t.'])); % orientation of t
x = x0 + t*ds;

%% Use Newton-Raphson method to refine guess
f_ = @(x) [f(x); (x-x0).' *t-ds]; % extended error and Jacobian matrix
df_ = @(x) [df(x); t.'];

x = utilities.newton(f_,df_,x,tol,n_iter);
















