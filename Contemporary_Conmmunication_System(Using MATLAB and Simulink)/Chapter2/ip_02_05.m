clc
clear
% MATLAB script for Illustrative Problem 5, Chapter 2.
echo on
% first part
n=0:31;
Sx1=ones(1,32);
Rx1=ifft(Sx1,32); 

figure
stem(n,fftshift(Rx1));
% second part
N=0:255;
Sx2=[ones(1,16),zeros(1,224),ones(1,16)];
Rx2=ifft(Sx2,256);
% plotting commands follow
figure
plot(N,fftshift(Rx2));
