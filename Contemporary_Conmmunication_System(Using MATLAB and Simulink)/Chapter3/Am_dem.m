% am-dem.m
% Matlab demonstration script for envelope detection. The message signal
% is +1 for 0 < t < t0/3, -2 for t0/3 < t < 2t0/3 and zero otherwise.
echo on
t0=.15;                              	% signal duration
ts=0.001;                            	% sampling interval
fc=250;                              	% carrier frequency
a=0.85;                              	% Modulation index
fs=1/ts;                             	% sampling frequency
t=[0:ts:t0];                         	% time vector
df=0.25;                             	% required frequency resolution
% message signal
m=[ones(1,t0/(3*ts)),-2*ones(1,t0/(3*ts)),zeros(1,t0/(3*ts)+1)];
c=cos(2*pi*fc.*t);                   	% carrier signal
m_n=m/max(abs(m));                   	% normalized message signal
[M,m,df1]=fftseq(m,ts,df);           	% Fourier transform 
f=[0:df1:df1*(length(m)-1)]-fs/2;    	% frequency vector
u=(1+a*m_n).*c;                      	% modulated signal
[U,u,df1]=fftseq(u,ts,df);           	% Fourier transform 
env=env_phas(u);                     	% find the envelope 
dem1=2*(env-1)/a;                    	% remove dc and rescale
signal_power=spower(u(1:length(t)));  	% power in modulated signal
noise_power=signal_power/100;        	% noise power
noise_std=sqrt(noise_power);         	% noise standard deviation
noise=noise_std*randn(1,length(u));  	% generate noise
r=u+noise;                           	% add noise to the modulated signal
[R,r,df1]=fftseq(r,ts,df);           	% Fourier transform 
env_r=env_phas(r);                   	% envelope, when noise is present
dem2=2*(env_r-1)/a;                  	% demodulate in the presence of noise
pause  % Press any key to see a plot of the message
subplot(2,1,1)
plot(t,m(1:length(t)))
axis([0 0.15 -2.1 2.1])
xlabel('Time')
title('The message signal')
pause  % Press any key to see a plot of the modulated signal
subplot(2,1,2)
plot(t,u(1:length(t)))
axis([0 0.15 -2.1 2.1])
xlabel('Time')
title('The modulated signal')
pause  % Press a key to see the envelope of the modulated signal
clf
subplot(2,1,1)
plot(t,u(1:length(t)))
axis([0 0.15 -2.1 2.1])
xlabel('Time')
title('The modulated signal')
subplot(2,1,2)
plot(t,env(1:length(t)))
xlabel('Time')
title('Envelope of the modulated signal')
pause  % Press a key to compare the message and the demodulated signal
clf
subplot(2,1,1)
plot(t,m(1:length(t)))
axis([0 0.15 -2.1 2.1])
xlabel('Time')
title('The message signal')
subplot(2,1,2)
plot(t,dem1(1:length(t)))
xlabel('Time')
title('The demodulated signal')
pause  % Press a key to compare in the presence of noise 
clf
subplot(2,1,1)
plot(t,m(1:length(t)))
axis([0 0.15 -2.1 2.1])
xlabel('Time')
title('The message signal')
subplot(2,1,2)
plot(t,dem2(1:length(t)))
xlabel('Time')
title('The demodulated signal in the presence of noise')
