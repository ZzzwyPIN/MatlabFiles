function [v,phi]=env_phas(x,ts,f0)
%		[v,phi]=env_phas(x,ts,f0)
%		      v=env_phas(x,ts,f0)
%ENV_PHAS   	Returns the envelope and the phase of the bandpass signal x.
%		f0 is the center frequency. 
%		ts is the sampling interval.
%
if nargout == 2
  z=loweq(x,ts,f0);
  phi=angle(z);
end
v=abs(hilbert(x));
