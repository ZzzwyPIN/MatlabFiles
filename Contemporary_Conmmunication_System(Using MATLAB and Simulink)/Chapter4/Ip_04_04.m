% MATLAB script for Illustrative Problem 4.4.

echo on ;
a=[-10,-5,-4,-2,0,1,3,5,10];
for i=1:length(a)-1
  y(i)=Centroid('Normal',a(i),a(i+1),0.001,0,1);
  echo off ;
end;


