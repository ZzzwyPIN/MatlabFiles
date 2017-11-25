function u=dsb_mod(m,ts,fc)
%		u=dsb_mod(m,ts,fc)
%DSB_MOD  	takes signal m sampled at ts and carrier
%		freq. fc as input and returns the DSB modulated
%		signal. ts << 1/2fc. The modulated signal
%		is normalized to have half the message power.
%		The message signal starts at 0.

t=[0:length(m)-1]*ts;
u=m.*cos(2*pi*fc*t);