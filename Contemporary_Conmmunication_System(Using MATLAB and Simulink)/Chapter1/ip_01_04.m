clc
clear
% MATLAB script for Illustrative Problem 4, Chapter 1.
echo on
n=[-20:1:20];
% Fourier series coefficients of x(t) vector 
x=.5*(sinc(n/2)).^2;
figure
stem(n,x);
axis([-10 10 0 0.5]);
title('周期信号的离散频谱');
% sampling interval
ts=1/40;
% time vector
t=[-.5:ts:1.5];
% impulse response
fs=1/ts;
h=[zeros(1,20),t(21:61),zeros(1,20)];
% transfer function
H=fft(h)/fs;
% frequency resolution
df=fs/80;
f=[0:df:fs]-fs/2;
% rearrange H
H1=fftshift(H);
H11=abs(H1);
figure
stem(f,H11);
axis([-20 20 0 0.6]);
title('冲激响应的频谱');
y=x.*H1(21:61);
% Plotting commands follow.
y1=abs(y);
figure
stem(n,y1);
axis([-10 10 0 0.3]);
title('系统输出的离散谱');


