function z=analytic(x)
%		z=analytic(x)
%ANALYTIC	Returns the analytic signal corresponding to signal x.
%		
z=hilbert(x);