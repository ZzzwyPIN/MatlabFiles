function y=rectab(x,a,b)
% y=rectab(x) determines a rectangular function of 
%	      width b centered at a (b>0)

y=((x>(a-b/2)) & (x<(a+b/2)))+.5*(x==(a-b/2))+0.5*(x==(a+b/2));