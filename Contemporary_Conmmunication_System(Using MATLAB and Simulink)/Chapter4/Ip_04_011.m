% MATLAB script for Illustrative Problem 4.11.
echo on
t=0:0.01:10;
a=sin(t);
[sqnr8,aquan8,code8]=U_pcm(a,8);
[sqnr16,aquan16,code16]=U_pcm(a,16);
% pause	% Press a key to see the SQNR for N = 8.
% sqnr8
% pause	% Press a key to see the SQNR for N = 16.
% sqnr16
pause	% Press a key to see the plot of the signal and its quantized versions.
plot(t,a,'-',t,aquan8,'-.',t,aquan16,'-',t,zeros(1,length(t)))