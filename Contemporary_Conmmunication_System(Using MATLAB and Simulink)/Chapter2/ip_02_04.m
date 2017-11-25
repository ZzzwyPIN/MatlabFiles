clc
clear

% MATLAB script for Illustrative Problem 2.4.
echo on
N=1000;
M=50;
Rx_av=zeros(1,M+1);
Sx_av=zeros(1,M+1);
%这里采取求十次自相关函数以及功率谱再求平均值的方法提高准确度。
for j=1:10        % Take the ensemble average over ten realizations
   X=rand(1,N)-1/2;    % N i.i.d. uniformly distributed random variables
               % between -1/2 and 1/2.
   Rx=Rx_est(X,M);%至此已经求出自相关函数          % autocorrelation of the realization
   Sx=fftshift(abs(fft(Rx)));%由维纳辛钦关系求出序列的功率谱   % power spectrum of the realization
   Rx_av=Rx_av+Rx;          % sum of the autocorrelations
   Sx_av=Sx_av+Sx;          % sum of the spectrums
   echo off ; 
end;
echo on ; 
Rx_av=Rx_av/10;                 % ensemble average autocorrelation
Sx_av=Sx_av/10;             % ensemble average spectrum
% Plotting comments follow
plot(Rx_av);
figure,plot(Sx_av)