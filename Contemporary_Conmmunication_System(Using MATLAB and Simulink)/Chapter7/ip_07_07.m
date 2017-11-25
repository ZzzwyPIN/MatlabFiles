% MATLAB script for Illustrative Problem 7.7. 
echo on
Tb=1;
f1=1000/Tb;
f2=f1+1/Tb;
phi=pi/4;
N=5000;   				% number of samples
t=0:Tb/(N-1):Tb;
u1=cos(2*pi*f1*t);
u2=cos(2*pi*f2*t);
% Assuming that u1 is transmitted, the received signal r is
sgma=1;					% noise variance
for i=1:N,
  r(i)=cos(2*pi*f1*t(i)+phi)+gngauss(sgma);
  echo off;
end;
echo on ;
% The correlator outputs are computed next.
v1=sin(2*pi*f1*t);
v2=sin(2*pi*f2*t);
r1c(1)=r(1)*u1(1);
r1s(1)=r(1)*v1(1);
r2c(1)=r(1)*u2(1);
r2s(1)=r(1)*v2(1);
for k=2:N,
  r1c(k)=r1c(k-1)+r(k)*u1(k);
  r1s(k)=r1s(k-1)+r(k)*v1(k);
  r2c(k)=r2c(k-1)+r(k)*u2(k);
  r2s(k)=r2s(k-1)+r(k)*v2(k);
  echo off;
end;
echo on;
% decision variables
r1=r1c(5000)^2+r1s(5000)^2;
r2=r2c(5000)^2+r2s(5000)^2;
% Plotting commands follow.