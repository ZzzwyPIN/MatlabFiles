clc
clear
% MATLAB script for Illustrative Problem 2.8. 
delta_w=2*pi/100;
w=-pi:delta_w:pi;           % one period of Sy
Sy=1./(1.9025-1.9*cos(w));
% Plotting command follows.
plot(w,Sy);
