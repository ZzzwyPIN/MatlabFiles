% MATLAB script for Illustrative Problem 12, Chapter 7.
echo on
alpha=0.4;
T=1/4800;
t=[-3*T:1.001*T/100:3*T];
x=sinc(t./T).*(cos(pi*alpha*t./T)./(1-4*alpha^2*t.^2/T^2));
pause % Press any key to see a plot of x(t).
plot(t,x)
y=xcorr(x);
ty=[t-3*T,t(2:length(t))+3*T];
pause % Press any key to see a plot of the autocorrelation of x(t).
plot(ty,y);
d=60;                   % Early and late advance and delay
ee=0.01;                % Precision
e=1;                    % Step size
n=700;                  % The incorrect sampling time
while abs(abs(y(n+d))-abs(y(n-d)))>=ee
  if abs(y(n+d))-abs(y(n-d))>0
    n=n+e;
  elseif abs(y(n+d))-abs(y(n-d))<0
    n=n-e;
  end
  echo off ;
end
echo on ;
pause % Press any key to see the corrected sampling time
n
n=500;                  % Another incorrect sampling time
while abs(abs(y(n+d))-abs(y(n-d)))>=ee
  if abs(y(n+d))-abs(y(n-d))>0
    n=n+e;
  elseif abs(y(n+d))-abs(y(n-d))<0
    n=n-e;
  end
  echo off ;
end
echo on ;
pause % Press any key to see the corrected sampling time
n
