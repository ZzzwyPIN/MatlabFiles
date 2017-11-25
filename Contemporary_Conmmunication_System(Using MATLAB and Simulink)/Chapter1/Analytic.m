function z=analytic(x)
%       z=analytic(x)
%ANALYTIC   returns the analytic signal corresponding to signal x
%       
z=hilbert(x);
