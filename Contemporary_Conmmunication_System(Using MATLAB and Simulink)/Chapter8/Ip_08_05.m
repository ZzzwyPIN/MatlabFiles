% MATLAB script for Illustrative Problem 8.5. 
echo off
w=[1:5:20,25:20:100,130:50:300,400:100:1000,1250:250:5000,5500:500:10000];
pn0_db=[-20:1:30];
pn0=10.^(pn0_db/10);
for i=1:45
  for j=1:51
    c(i,j)=w(i)*log2(1+pn0(j)/w(i));
  end
end
echo on
pause % Press a key to see C vs. W and P/N0.
k=[0.9,0.8,0.5,0.6];
s=[-70,35];
surfl(w,pn0_db,c',s,k)
title('Capacity vs. bandwidth and SNR')
