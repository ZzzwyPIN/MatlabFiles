% MATLAB script for Illustrative Problem 11, Chapter 7
echo on
num=[0.01 1];
den=[1 1.01 1];
[a,b,c,d]=tf2ss(num,den);
dt=0.01;
u=ones(1,2000);
x=zeros(2,2001);
for i=1:2000
  x(:,i+1)=x(:,i)+dt.*a*x(:,i)+dt.*b*u(i);
  y(i)=c*x(:,i);
  echo off;
end
echo on;
t=[0:dt:20];
plot(t(1:2000),y)
