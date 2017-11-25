% ip_04_08.m added for spar
clc
clear

n=10;
tol=0.01;
p1=0;
p2=1;
b=10*p2;
[a,y,dist]=Lloydmax('Normal',b,n,tol,p1,p2);
