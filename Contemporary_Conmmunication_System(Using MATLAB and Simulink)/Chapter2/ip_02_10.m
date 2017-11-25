clc
clear
%MATLAB script for Illustrative Problem 2.10.
N=1000;                         % number of samples
for i=1:2:N
   [X1(i) X1(i+1)]=Gngauss;
   [X2(i) X2(i+1)]=Gngauss;
  echo off ;
end;                        % standard Gaussian input noise processes   
echo on ;
% plot(X1,'r');
A=[1 -0.9];                 % lowpass filter parameters
B=1;
Xc=filter(B,A,X1);       
Xs=filter(B,A,X2);
% hold on
% plot(Xc);
fc=1000/pi;                 % carrier frequency 
for i=1:N
   band_pass_process(i)=Xc(i)*cos(2*pi*fc*i)-Xs(i)*sin(2*pi*fc*i);
   echo off ; 
end;                        % T=1 is assumed.
echo on; 
% Determine the autocorrelation and the spectrum of the bandpass process.
M=50;
bpp_autocorr=Rx_est(band_pass_process,M);
bpp_spectrum=fftshift(abs(fft(bpp_autocorr)));

% Plotting commands follow.
f=(0:20:N)/N-1/2;%划定频率范围
plot(f,bpp_spectrum);%因为X1、X2是随机的，所以每次画的图形都有一些不同。

