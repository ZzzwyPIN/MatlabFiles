% MATLAB script for Illustrative Problem 4.12.
clc
clear

echo on
a=randn(1,500);
n=64;
[sqnr,a_quan,code]=U_pcm(a,64);
pause	% Press a key to see the SQNR.
sqnr
pause	% Press a key to see the first five input values.
a(1:5)
pause	% Press a key to see the first five quantized values.
a_quan(1:5)
pause	% Press a key to see the first five codewords.
code(1:5,:)

