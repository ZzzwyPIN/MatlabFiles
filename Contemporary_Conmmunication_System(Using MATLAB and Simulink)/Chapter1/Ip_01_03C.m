clc
clear
t=-6:0.1:6;
fs=120;
x=(1/sqrt(2*pi))*exp(-t.^2/2);
%stem(t,x);
X=fft(x);
XX1=X/fs;
X1=fftshift(XX1);
f=(0:1:fs)-fs/2;
stem(f,abs(X1));

