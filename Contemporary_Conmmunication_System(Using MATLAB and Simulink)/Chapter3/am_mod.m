function u=am_mod(a,m,ts,fc)
%       u=am_mod(a,m,ts,fc)
%AM_MOD     takes signal m sampled at ts and carrier
%       freq. fc as input and returns the AM modulated
%       signal. "a" is the modulation index
%       and ts << 1/2fc. 

t=[0:length(m)-1]*ts;
c=cos(2*pi*fc.*t);                 
m_n=m/max(abs(m)); 
u=(1+a*m_n).*c;          
