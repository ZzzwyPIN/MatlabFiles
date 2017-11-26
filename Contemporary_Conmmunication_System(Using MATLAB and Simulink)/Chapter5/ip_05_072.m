% MATLAB script for Illustrated Problem 5.7.2
clc
clear

echo on
n0=.3*randn(100,1);
n1=.3*randn(100,1);
n2=.3*randn(100,1);
n3=.3*randn(100,1);
x1=1.+n0;
y1=n1;
x2=n2;
y2=1.+n3;
plot(x1,y1,'o',x2,y2,'*')
axis('square')