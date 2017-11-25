% fm1.m
% Matlab demonstration script for frequency modulation. The message signal
% is +1 for 0 < t < t0/3, -2 for t0/3 < t < 2t0/3 and zero otherwise.
echo on
t0=.15;                              	% signal duration
ts=0.0005;                           	% sampling interval
fc=200;                              	% carrier frequency
kf=50;                               	% Modulation index
fs=1/ts;                             	% sampling frequency
t=[0:ts:t0];                         	% time vector
df=0.25;                             	% required frequency resolution
% message signal
m=[ones(1,t0/(3*ts)),-2*ones(1,t0/(3*ts)),zeros(1,t0/(3*ts)+1)];
int_m(1)=0;
for i=1:length(t)-1                  	% Integral of m
  int_m(i+1)=int_m(i)+m(i)*ts;
  echo off ;
end
echo on ;
[M,m,df1]=fftseq(m,ts,df);           	% Fourier transform 
M=M/fs;                              	% scaling
f=[0:df1:df1*(length(m)-1)]-fs/2;    	% frequency vector
u=cos(2*pi*fc*t+2*pi*kf*int_m);      	% modulated signal
[U,u,df1]=fftseq(u,ts,df);           	% Fourier transform 
U=U/fs;                              	% scaling
pause  % Press any key to see a plot of the message and the modulated signal
subplot(2,1,1)
plot(t,m(1:length(t)))
axis([0 0.15 -2.1 2.1])
xlabel('Time')
title('The message signal')
subplot(2,1,2)
plot(t,u(1:length(t)))
axis([0 0.15 -2.1 2.1])
xlabel('Time')
title('The modulated signal')
pause   % Press any key to see a plots of the magnitude of the message and the
	% modulated signal in the frequency domain.
subplot(2,1,1)
plot(f,abs(fftshift(M))) 
xlabel('Frequency')
title('Magnitude-spectrum of the message signal')
subplot(2,1,2)
plot(f,abs(fftshift(U))) 
title('Magnitude-spectrum of the modulated signal')
xlabel('Frequency')