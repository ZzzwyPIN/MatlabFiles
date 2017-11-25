function u=lssb_mod(m,ts,fc)
%		u=lssb_mod(m,ts,fc)
%LSSB_MOD  	takes signal m sampled at ts and carrier
%		freq. fc as input and returns the LSSB modulated
%		signal. ts << 1/2fc. 
t=[0:length(m)-1]*ts;
u=m.*cos(2*pi*t)+imag(hilbert(m)).*sin(2*pi*t);