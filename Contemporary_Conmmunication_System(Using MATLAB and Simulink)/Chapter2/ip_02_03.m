clc
clear
% MATLAB script for Illustrative Problem 2.3.
echo on
rho=0.95;                             
X0=0;
N=1000;
X=Gaus_mar(X0,rho,N);                 
M=50;
Rx=Rx_est(X,M);               
% Plotting commands follow.
plot(X);
figure,plot(Rx)
%后两命是加上的