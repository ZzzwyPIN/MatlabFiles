function u=ussb_mod(m,ts,fc)
%		u=ussb_mod(m,ts,fc)
%USSB_MOD  	takes signal m sampled at ts and carrier
%		freq. fc as input and returns the USSB modulated
%		signal. ts << 1/2fc. 
t=[0:length(m)-1]*ts;
u=m.*cos(2*pi*t)-imag(hilbert(m)).*sin(2*pi*t);