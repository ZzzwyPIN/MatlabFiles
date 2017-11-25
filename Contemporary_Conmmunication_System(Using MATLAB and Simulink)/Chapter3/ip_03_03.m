% MATLAB script for Illustrative Problem 3.3.
% Demonstration script for DSB-AM modulation. The message signal
% is +1 for 0 < t < t0/3, -2 for t0/3 < t < 2t0/3, and zero otherwise.
clc
clear

echo on
t0=.15;                                 % signal duration
ts=0.001;                               % sampling interval
fc=250;                                 % carrier frequency
snr=10;                                 % SNR in dB (logarithmic)
a=0.85;                                 % modulation index
fs=1/ts;                                % sampling frequency
t=0:ts:t0;                           % time vector
df=0.2;                                 % required frequency resolution
snr_lin=10^(snr/10);                    % SNR
% message signal
m=[ones(1,t0/(3*ts)),-2*ones(1,t0/(3*ts)),zeros(1,t0/(3*ts)+1)];
c=cos(2*pi*fc.*t);                      % carrier signal
m_n=m/max(abs(m));                      % normalized message signal 归一化
[M,m,df1]=Fftseq(m,ts,df);              % Fourier transform 
M=M/fs;                                 % scaling
f=(0:df1:df1*(length(m)-1))-fs/2;       % frequency vector
u=(1+a*m_n).*c;                         % modulated signal
[U,u,df1]=Fftseq(u,ts,df);              %#ok<*ASGLU> % Fourier transform 
U=U/fs;                                 % scaling
signal_power=spower(u(1:length(t)));    % power in modulated signal
% power in normalized message
pmn=spower(m(1:length(t)))/(max(abs(m)))^2;%归一化消息信号功率。
eta=(a^2*pmn)/(1+a^2*pmn);              % modulation efficiency
noise_power=eta*signal_power/snr_lin;   % noise power
noise_std=sqrt(noise_power);            % noise standard deviation
noise=noise_std*randn(1,length(u));     % Generate noise.
r=u+noise;                              % Add noise to the modulated signal
[R,r,df1]=Fftseq(r,ts,df);              % Fourier transform.
R=R/fs;                                 % scaling
% pause  % Press a key to show the modulated signal power.
% signal_power
% pause  % Press a key to show the modulation efficiency.
% eta
pause  % Press any key to see a plot of the message.
subplot(2,2,1)
plot(t,m(1:length(t)))
axis([0 0.15 -2.1 2.1])
xlabel('Time')
title('The message signal')
pause
pause  % Press any key to see a plot of the carrier.
subplot(2,2,2)
plot(t,c(1:length(t)))
axis([0 0.15 -2.1 2.1])
xlabel('Time')
title('The carrier') 
pause  % Press any key to see a plot of the modulated signal.
subplot(2,2,3)
plot(t,u(1:length(t)))
axis([0 0.15 -2.1 2.1])
xlabel('Time')
title('The modulated signal')
pause   % Press any key to see plots of the magnitude of the message and the
    % modulated signal in the frequency domain.
subplot(2,1,1)
plot(f,abs(fftshift(M))) 
xlabel('Frequency')
title('Spectrum of the message signal')
subplot(2,1,2)
plot(f,abs(fftshift(U))) 
title('Spectrum of the modulated signal')
xlabel('Frequency')
pause  % Press a key to see a noise sample.
subplot(2,1,1)
plot(t,noise(1:length(t))) 
title('Noise sample') 
xlabel('Time')
pause  % Press a key to see the modulated signal and noise.
subplot(2,1,2)
plot(t,r(1:length(t))) 
title('Signal and noise')
xlabel('Time')
pause  % Press a key to see the modulated signal and noise in freq. domain.
subplot(2,1,1)
plot(f,abs(fftshift(U))) 
title('Signal spectrum')
xlabel('Frequency')
subplot(2,1,2)
plot(f,abs(fftshift(R))) 
title('Signal and noise spectrum')
xlabel('Frequency')
