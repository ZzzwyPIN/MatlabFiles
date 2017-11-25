% MATLAB script for Illustrative Problem 8.3.
echo on
a_db=[-20:0.2:20];
a=10.^(a_db/10);
for i=1:201
  f(i)=quad('il3_8fun',a(i)-5,a(i)+5,1e-3,[],a(i));
  g(i)=quad('il3_8fun',-a(i)-5,-a(i)+5,1e-3,[],-a(i));
  c(i)=0.5*f(i)+0.5*g(i);
  echo off ;
end
echo on ;
pause % Press a key to see capacity vs. SNR plot.
semilogx(a,c)
title('Capacity versus SNR in binary input AWGN channel')
xlabel('SNR')
ylabel('Capacity (bits/transmission)')

