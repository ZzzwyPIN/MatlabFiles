% MATLAB script for Illustrative Problem 4.14.2.
clc
clear

echo on
a=randn(1,500);
n=128;
[sqnr,a_quan,code]=U_pcm(a,128);
% pause	% Press a key to see the SQNR.
% sqnr
% pause	% Press a key to see the first five input values.
% a(1:5)
% pause	% Press a key to see the first five quantized values.
% a_quan(1:5)
% pause	% Press a key to see the first five codewords.
% code(1:5,:)
plot(a-a_quan)
[Y,I]=sort(a);
figure,plot(Y,a_quan(I))