% MATLAB script for Illustrative Problem 8.7 
echo on
ep=0.3;
for i=1:2:61
  p(i)=0;
  for j=(i+1)/2:i
    p(i)=p(i)+prod(1:i)/(prod(1:j)*prod(1:(i-j)))*ep^j*(1-ep)^(i-j);
    echo off ;
  end
end
echo on ;
pause % Press a key to see the plot.
stem((1:2:61),p(1:2:61))
xlabel('n')
ylabel('pe')
title('Error probability as a function of n in simple repetition code')

