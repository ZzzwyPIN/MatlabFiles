% MATLAB script for Illustrative Problem 3.4.
% Demonstration script for LSSB-AM modulation. The message signal
% is +1 for 0 < t < t0/3, -2 for t0/3 < t < 2t0/3, and zero otherwise. 
clc
clear

echo on 
t0=.15;                                 % signal duration
ts=0.001;                               % sampling interval
fc=250;                                 % carrier frequency
snr=10;                                 % SNR in dB (logarithmic)
fs=1/ts;                                % sampling frequency
df=0.25;                                % desired freq. resolution
t=0:ts:t0;                            % time vector
snr_lin=10^(snr/10);                    % SNR
% the message vector
m=[ones(1,t0/(3*ts)),-2*ones(1,t0/(3*ts)),zeros(1,t0/(3*ts)+1)];
c=cos(2*pi*fc.*t);                      % carrier vector
udsb=m.*c;                              % DSB modulated signal
[UDSB,udssb,df1]=Fftseq(udsb,ts,df);    % Fourier transform
UDSB=UDSB/fs;                           % scaling
f=(0:df1:df1*(length(udssb)-1))-fs/2;   % frequency vector
n2=ceil(fc/df1);                        % location of carrier in freq. vector
% Remove the upper sideband from DSB.
UDSB(n2:length(UDSB)-n2)=zeros(size(UDSB(n2:length(UDSB)-n2)));
ULSSB=UDSB;                             % Generate LSSB-AM spectrum.%关于Y轴对称的内边带全部被清掉了。
[M,m,df1]=Fftseq(m,ts,df);              %#ok<*ASGLU> % Fourier transform
M=M/fs;                                 % scaling
u=real(ifft(ULSSB))*fs;                 % Generate LSSB signal from spectrum.
signal_power=spower(udsb(1:length(t)))/2;          
%                                       % Compute signal power.
noise_power=signal_power/snr_lin;       % Compute noise power.
noise_std=sqrt(noise_power);            % Compute noise standard deviation.
noise=noise_std*randn(1,length(u));     % Generate noise vector.
r=u+noise;                              % Add the signal to noise.
[R,r,df1]=Fftseq(r,ts,df);              % Fourier transform
R=R/fs;                                 % scaling
% pause  % Press a key to show the modulated signal power.
% signal_power
% pause  % Press any key to see a plot of the message signal.
clf
subplot(2,1,1)
plot(t,m(1:length(t)))
axis([0,0.15,-2.1,2.1])
xlabel('Time')
title('The message signal') 
pause  % Press any key to see a plot of the carrier.
subplot(2,1,2)
plot(t,c(1:length(t))) 
xlabel('Time')
title('The carrier') 
pause  % Press any key to see a plot of the modulated signal and its spectrum.
clf
subplot(2,1,1) 
plot([0:ts:ts*(length(u)-1)/8],u(1:length(u)/8)) 
xlabel('Time')
title('The LSSB-AM modulated signal') 
subplot(2,1,2)
plot(f,abs(fftshift(ULSSB)))
xlabel('Frequency')
title('Spectrum of the LSSB-AM modulated signal')
pause   % Press any key to see the spectra of the message and the modulated signals.
clf 
subplot(2,1,1)
plot(f,abs(fftshift(M)))
xlabel('Frequency')
title('Spectrum of the message signal')
subplot(2,1,2)
plot(f,abs(fftshift(ULSSB)))
xlabel('Frequency')
title('Spectrum of the LSSB-AM modulated signal')

pause  % Press any key to see a noise sample.
subplot(2,1,1)
plot(t,noise(1:length(t)))
title('Noise sample') 
xlabel('Time')
pause  % Press a key to see the modulated signal and noise.
subplot(2,1,2)
plot(t,r(1:length(t)))
title('Modulated signal and noise')
xlabel('Time')
subplot(2,1,1)
pause % Press any key to see the spectrum of the modulated signal.
plot(f,abs(fftshift(ULSSB)))
title('Modulated signal spectrum')
xlabel('Frequency')
subplot(2,1,2)


pause  % Press a key to see the modulated signal noise in freq. domain.
plot(f,abs(fftshift(R))) 
title('Modulated signal noise spectrum')
xlabel('Frequency')
