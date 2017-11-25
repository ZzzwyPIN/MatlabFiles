% Example of Plotting the Discrete Spectrum 
echo on
function='lambda';
a=-1.3;
b=3.3;
n=24;
tol=0.1;
xx=fseries(function,a,b,n,tol);
xx1=xx(n+1:-1:2);
xx1=[conj(xx1),xx];
absxx1=abs(xx1);
pause  % Press any key to see a plot of the magnitude spectrum
n1=[-n:n];
stem(n1,absxx1)
title('The Discrete Magnitude Spectrum')
phasexx1=angle(xx1);
pause  % Press any key to see a plot of the phase spectrum
stem(n1,phasexx1)
title('The Discrete Phase Spectrum')