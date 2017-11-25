% MATLAB script for Illustrative Problem 8.8. 
% Generate U, denoting all information sequences.
k=4;
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
% Define G, the generator matrix.
g=[1 0 0 1 1 1 0 1 1 1;
   1 1 1 0 0 0 1 1 1 0;
   0 1 1 0 1 1 0 1 0 1;
   1 1 0 1 1 1 1 0 0 1];
% Generate codewords.
c=rem(u*g,2);
% Find the minimum distance.
w_min=min(sum((c(2:2^k,:))'));

