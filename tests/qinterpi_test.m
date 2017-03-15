%{
Compendium of all tests for the function/class in the name of this file.
You can run the tests by executing runtests. You must add the package to
your path first. 

%----------------------------------------------------------------------
Author: Mario Merino
Date: 20170314
%----------------------------------------------------------------------
%}
function tests = qinterpi_test
    tests = functiontests(localfunctions);
end

%----------------------------------------------------------------------
%----------------------------------------------------------------------
%----------------------------------------------------------------------
 
function test_example_qinterpi(t)
    X = linspace(-2,5,59);
    [l,h,s] = utilities.qinterpi(X,rand(2,3,4)*3);
    [l,h,s,i] = utilities.qinterpi(X,rand(2,3,4)*20);
end

