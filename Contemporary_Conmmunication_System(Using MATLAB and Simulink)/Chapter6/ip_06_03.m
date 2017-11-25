% MATLAB script for Illustrative Problem 6.3.
echo on
f_cutoff=2000;				% the desired cutoff frequency
f_stopband=2500;			% the actual stopband frequency
fs=10000;				% the sampling frequency
f1=2*f_cutoff/fs;			% the normalized passband frequency
f2=2*f_stopband/fs;			% the normalized stopband frequency
N=41;					% This number is found by experiment.
F=[0 f1 f2 1];		
M=[1 1 0 0];				% describes the lowpass filter
B=remez(N-1,F,M);			% returns the FIR tap coefficients
% Plotting command follows.
figure(1);
[H,W]=freqz(B);
H_in_dB=20*log10(abs(H));
plot(W/(2*pi),H_in_dB);
figure(2);
plot(W/(2*pi),(180/pi)*unwrap(angle(H)));
% Plot of the impulse response follows.
figure(3);
plot(zeros(size([0:N-1])));
hold;
stem([0:N-1],B);