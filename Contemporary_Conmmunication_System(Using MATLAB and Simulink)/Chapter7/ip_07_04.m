% MATLAB script for Illustrative Problem 7.4
mapping=[0 1 3 2 7 6 4 5];	 	% for Gray mapping
M=8;
E=1;
sequence=[0 1 0  0 1 1  0 0 1  1 1 1  1 1 0  0 0 0];
[e]=cm_dpske(E,M,mapping,sequence);	% e is the differential encoder output.