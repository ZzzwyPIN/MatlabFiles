% dsb1.m
% Matlab demonstration script for DSB-AM modulation. The message signal
% is +1 for 0 < t < t0/3, -2 for t0/3 < t < 2t0/3 and zero otherwise.
echo on
t0=.15;                              	% signal duration
ts=0.0005;                           	% sampling interval
fc=250;                              	% carrier frequency
snr=10;                              	% SNR in dB (logarithmic)
fs=1/ts;                             	% sampling frequency
t_long=20*t0;                        	% extended signal duration 
n0=floor(t_long/ts)+1;               	% length of extended signal vector 
n00=2^(ceil(log2(n0)));
df=fs/n00;                            	% frequency resolution
t_long1=[0:ts:t_long];               	% extended time vector
f=[-fs/2+df:df:fs/2];                	% frequency vector 
% message signal
m=[ones(1,t0/(3*ts)),-2*ones(1,t0/(3*ts)),zeros(1,t0/(3*ts)+1)];
m_long=[m,zeros(1,n0-length(m))];    	% extended message signal 
c_long=cos(2*pi*fc.*t_long1);        	% extended carrier signal 
u_long=m_long.*c_long;               	% extended modulated signal
du_long=u_long.*c_long;
DU=fft(du_long,n00)/fs;
M=fft(m_long,n00)/fs;                 	% spectrum of the extended message signal 
U=fft(u_long,n00)/fs;                  	% spectrum of the extended modulated signal 
pause   % Press any key to see a plots of the magnitude of the message and the
	% modulated signal in the frequency domain.
subplot(2,1,1)
plot(f,abs(fftshift(M)))
xlabel('Frequency')
title('Spectrum of the message signal')
subplot(2,1,2)
plot(f,abs(fftshift(U)))
title('Spectrum of the modulated signal')
xlabel('Frequency') 
pause  % Press a key to see the modulated and modulated X carrier in freq. domain
subplot(2,1,1)
plot(f,abs(fftshift(U)))
title('Modulated signal spectrum')
xlabel('Frequency')
subplot(2,1,2)
plot(f,abs(fftshift(DU))) 
title('Modulated signal X Carrier spectrum')
xlabel('Frequency')

