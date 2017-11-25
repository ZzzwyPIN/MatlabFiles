% MATLAB script for Illustrative Problem 8.6.
echo on
p_db=[-20:1:20];
np_db=p_db;
p=10.^(p_db/10);
np=p; 
for i=1:41
  for j=1:41
    c(i,j)=0.5*log2(1+p(i)/np(j));
    echo off ;
  end
end
echo on ;
pause % Press a key to see the plot.
surfl(np_db,p_db,c)