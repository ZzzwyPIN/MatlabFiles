function [xc,xs]=quadcomp(x,ts,f0)
%		[xc,xs]=quadcomp(x,ts,f0)
%QUADCOMP  	Returns the in-phase and quadrature components of 
%		the signal x. f0 is the center frequency. ts is the
%		sampling interval.
%		
z=Loweq(x,ts,f0);
xc=real(z);
xs=imag(z);