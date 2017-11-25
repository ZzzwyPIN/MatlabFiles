function y=rect(x)
% y=rect(x), determines the rectangular function

y=((x>-0.5) & (x<0.5))+0.5*(x==-0.5)+0.5*(x==0.5);
