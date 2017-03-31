%{
Computes N-dimensional gradient vector of a quantity FF on a structured
grid XX,YY,ZZ,..., not necessarily purely Cartesian. At each point,
least squares of uncentered derivatives with connected neighboring
points are used. The domain boundary is correctly treated

If a given dimension is a singleton dimension (i.e. length along that
dimension equal to 1), the derivatives along that direction are returned
equal to zero and warnings are rised. You can deactivate warnings by
calling the function as follows:

    original_warning_state = warning;
    warning('off','MATLAB:rankDeficientMatrix');
    [...] = utilities.gradient_nd(...);
    warning(original_warning_state);

INPUT:
* The first N inputs: A total of N arrays of dimension N containing the
  structured grid 
* The N+1 input: the N dimensional array containing the values of the
  function to be differentiated

OUTPUT:
* N outputs: reconstructed derivatives in the in the N directions in the
  same order as the inputs

%----------------------------------------------------------------------
Author: Mario Merino
Date: 20170331
%----------------------------------------------------------------------
%}
function [varargout] = gradient(varargin)

%% Allocate 
Nd = nargin-1;
Np = numel(varargin{1});
Nx = ones(Nd,1); % This pads with ones in case ndims(varargin{1}) < Nd
Nx(1:ndims(varargin{1})) = size(varargin{1}); 
for id = 1:Nd
    varargout{id} = varargin{1}.*0; %#ok<AGROW>
end

%% Computation
for ip = 1:Np
    % Find indices of current point
    t = ip;
    ix = zeros(Nd,1);
    for id = Nd:-1:1
        ix(id) = ceil(t/prod(Nx(1:id-1)));
        t = mod(t-1,prod(Nx(1:id-1)))+1;
    end

    % Build coefficient + independent term matrix 
    A = zeros(Nd*2,Nd+1);
    for ie = 1:Nd % equation index (doubled)
        if ix(ie)>1 % Equation -, only if we are not at that border
            for id = 1:Nd+1 % dimension index, including function at the end
                A(ie*2,id) = varargin{id}(ip-prod(Nx(1:ie-1)))-varargin{id}(ip);
            end
            A(ie*2,:) = A(ie*2,:)/norm(A(ie*2,1:Nd));
        else
            A(ie*2,:) = 0;
        end
        if ix(ie)<Nx(ie) % Equation +, only if we are not at that border
            for id = 1:Nd+1 % dimension index, including function at the end 
                A(ie*2-1,id) = varargin{id}(ip+prod(Nx(1:ie-1)))-varargin{id}(ip);
            end
            A(ie*2-1,:) = A(ie*2-1,:)/norm(A(ie*2-1,1:Nd));
        else
            A(ie*2-1,:) = 0;
        end
    end

    % Solve least squares and assign output
    D = A(:,1:Nd)\A(:,Nd+1);
    for id = 1:Nd
        varargout{id}(ip) = D(id);
    end 
end
