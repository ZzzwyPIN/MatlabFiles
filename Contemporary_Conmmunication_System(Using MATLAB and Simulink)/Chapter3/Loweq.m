function xl=Loweq(x,ts,f0)
%		xl=loweq(x,ts,f0)
%LOWEQ		Returns the lowpass equivalent of the signal x.
%		f0 is the center frequency. 
%		ts is the sampling interval.
%	
t=[0:ts:ts*(length(x)-1)];	
z=hilbert(x);
xl=z.*exp(-j*2*pi*f0*t);