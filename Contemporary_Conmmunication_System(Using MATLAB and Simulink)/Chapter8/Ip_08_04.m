% MATLAB script for Illustrative Problem 8.4.  
echo on
a_db=[-13:0.5:13];
a=10.^(a_db/10);
c_hard=1-entropy2(Q(a));
for i=1:53
  f(i)=quad('il3_8fun',a(i)-5,a(i)+5,1e-3,[],a(i));
  g(i)=quad('il3_8fun',-a(i)-5,-a(i)+5,1e-3,[],-a(i));
  c_soft(i)=0.5*f(i)+0.5*g(i);
  echo off ;
end
echo on ;
pause % Press a key to see the capacity curves.
semilogx(a,c_soft,a,c_hard)

