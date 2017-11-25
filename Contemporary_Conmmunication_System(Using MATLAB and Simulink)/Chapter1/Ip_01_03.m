% MATLAB script for Illustrative Problem 3, Chapter 1.
echo on
fnct='Normal';
a=-6;
b=6;
n=40;
tol=0.1;
xx=Fseries(fnct,a,b,n,tol,0,1);
xx1=xx(n+1:-1:2);
xx1=[conj(xx1),xx];
absxx1=abs(xx1);
n1=[-n:n];
stem(n1,absxx1)
title('The Discrete Magnitude Spectrum')
phasexx1=angle(xx1);
pause % Press any key to see a plot of the phase.
stem(n1,phasexx1)
title('The Discrete Phase Spectrum')
