% MATLAB script for Illustrative Problem 6, Chapter 1
%{
    通过本例知道了fftseq函数的用法。其中，x是输入即将做FFT的信号，ts是采样间隔，df是要求分辨率。
    输出X为做完FFT的信号，df1为输出分辨率。
%}
echo on
ts=0.2;                     % set parameters
fs=1/ts;
df=0.01;
x=[zeros(1,10),[0:0.2:1],ones(1,9),[1:-0.2:0],zeros(1,10)];%x为信号x(t)的冲激抽样信号
[X,x,df1]=Fftseq(x,ts,df);          % derive the FFT
X1=X/fs;                                    % scaling缩放
f=[0:df1:df1*(length(x)-1)]-fs/2;           % frequency vector for FFT
f1=[-2.5:0.001:2.5];                        % frequency vector for analytic approach
y=4*(sinc(2*f1)).^2-(sinc(f1)).^2;          % exact Fourier transform
%pause % Press akey to see the plot of the Fourier Transform derived analytically.
%clf%清除当前figure
subplot(2,1,1)
plot(f1,abs(y));
xlabel('Frequency')
title('Magnitude-pectrum of x(t) derived analytically')
%pause % Press akey to see the plot of the Fourier Transform derived numerically.
subplot(2,1,2)
plot(f,fftshift(abs(X1)));
xlabel('Frequency')
title('Magnitude-pectrum of x(t) derived numerically')
