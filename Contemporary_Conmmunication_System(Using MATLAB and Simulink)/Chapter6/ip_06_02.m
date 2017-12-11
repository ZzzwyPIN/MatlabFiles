% MATLAB script for Illustrative Problem 6.2.
clc
clear

echo on
T=1;
delta_f=1/(100*T);		
f=-5/T:delta_f:5/T;
Sv=2*(cos(pi*f*T).*sinc(f*T)).^2;
% Plotting command follows.
plot(f,Sv);