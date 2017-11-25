function y=sinc(x)
% Y=SINC(X), determines the sinc function

y=(sin(pi*x)+(x==0))./(pi*x+(x==0));
