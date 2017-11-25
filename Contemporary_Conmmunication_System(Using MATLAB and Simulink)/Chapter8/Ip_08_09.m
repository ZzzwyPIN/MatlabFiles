% MATLAB script for Illustrative Problem 8.9.
echo on
k=11;
for i=1:2^k
  for j=k:-1:1
    if rem(i-1,2^(-j+k+1))>=2^(-j+k)
      u(i,j)=1;
    else
      u(i,j)=0;
    end
    echo off ;
  end
end
echo on ;

g=[1 0 0 0 0 0 0 0 0 0 0 1 1 0 0;
   0 1 0 0 0 0 0 0 0 0 0 0 1 1 0;
   0 0 1 0 0 0 0 0 0 0 0 0 0 1 1;
   0 0 0 1 0 0 0 0 0 0 0 1 0 1 0;
   0 0 0 0 1 0 0 0 0 0 0 1 0 0 1;
   0 0 0 0 0 1 0 0 0 0 0 0 1 0 1;
   0 0 0 0 0 0 1 0 0 0 0 1 1 1 0;
   0 0 0 0 0 0 0 1 0 0 0 0 1 1 1;
   0 0 0 0 0 0 0 0 1 0 0 1 0 1 1;
   0 0 0 0 0 0 0 0 0 1 0 1 1 0 1;
   0 0 0 0 0 0 0 0 0 0 1 1 1 1 1];

c=rem(u*g,2);
w_min=min(sum((c(2:2^k,:))'));


