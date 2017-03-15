%{
Compendium of all tests for the function/class in the name of this file.
You can run the tests by executing runtests. You must add the package to
your path first. 

%----------------------------------------------------------------------
Author: Mario Merino
Date: 20170314
%----------------------------------------------------------------------
%}
function tests = meshgrid_inclined_plane_test
    tests = functiontests(localfunctions);
end

%----------------------------------------------------------------------
%----------------------------------------------------------------------
%----------------------------------------------------------------------
 
function test_example_plane_creation(t)
    o = [1,2,3];
    v1 = [0.3,0.4,0];
    v2 = [0,0,1];
    t1Lim = [0,1];
    t2Lim = [-2,2];
    t1points = 100;
    t2points = 200;
    [XX,YY,ZZ] = utilities.meshgrid_inclined_plane(o,v1,v2,t1Lim,t2Lim,t1points,t2points);
end
