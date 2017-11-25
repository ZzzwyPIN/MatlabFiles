clc
clear
% MATLAB script for Illustrative Problem 2.2.
echo on
mx=[0 0]';
Cx=[1 1/2;1/2 1];
x=Multi_gp(mx,Cx);%用生成的x估算(x1,x2)的大致范围。  
% Computation of the pdf of (x1,x2) follows.
delta=0.3;
x1=-3:delta:3;
x2=-3:delta:3;
for i=1:length(x1)
   for j=1:length(x2)
      f(i,j)=(1/((2*pi)*det(Cx)^1/2))*exp((-1/2)*(([x1(i) x2(j)]-mx')*inv(Cx)*([x1(i);x2(j)]-mx))); 
      echo off ; 
   end;
end;
echo on ;
% Plotting command for pdf follows.
mesh(x1,x2,f);
