% MATLAB script for Illustrative Problem 3.11.
% Demonstration script for frequency modulation. The message signal
% is m(t)=sinc(100t).
clc
clear

echo on
t0=.2;                               	% signal duration
ts=0.001;                            	% sampling interval
fc=250;                              	% carrier frequency
snr=20;                              	% SNR in dB (logarithmic)
fs=1/ts;                             	% sampling frequency
t=-t0/2:ts:t0/2;                   	% time vector
kf=100;                              	% deviation constant
df=0.25;                             	% required frequency resolution
m=sinc(100*t);                       	% the message signal
int_m(1)=0;
for i=1:length(t)-1                  	% integral of m
  int_m(i+1)=int_m(i)+m(i)*ts; %#ok<SAGROW>
  echo off ;
end
echo on ;
[M,m,df1]=Fftseq(m,ts,df);           	% Fourier transform 
M=M/fs;                              	% scaling
f=(0:df1:df1*(length(m)-1))-fs/2;    	% frequency vector
u=cos(2*pi*fc*t+2*pi*kf*int_m);      	% modulated signal
[U,u,df1]=Fftseq(u,ts,df);           	% Fourier transform 
U=U/fs;                              	% scaling
[v,phase]=env_phas(u,ts,250);        	% demodulation, find phase of u

phi=unwrap(phase);                   	% Restore original phase.解除相位跳变。

dem=(1/(2*pi*kf))*(diff(phi)/ts);    	% demodulator output, differentiate and scale phase diff:求一阶导数。

pause  % Press any key to see a plot of the message and the modulated signal.
subplot(2,1,1)
plot(t,m(1:length(t)))
xlabel('Time')
title('The message signal')
subplot(2,1,2)
plot(t,u(1:length(t)))
xlabel('Time')
title('The modulated signal')
pause   % Press any key to see plots of the magnitude of the message and the
	% modulated signal in the frequency domain.
subplot(2,1,1)
plot(f,abs(fftshift(M))) 
xlabel('Frequency')
title('Magnitude spectrum of the message signal')
subplot(2,1,2)
plot(f,abs(fftshift(U))) 
title('Magnitude-spectrum of the modulated signal')
xlabel('Frequency')
pause	% Press any key to see plots of the message and the demodulator output with no
        % noise.
subplot(2,1,1)
plot(t,m(1:length(t)))
xlabel('Time')
title('The message signal')
subplot(2,1,2)
plot(t,dem(1:length(t)))
xlabel('Time')
title('The demodulated signal')