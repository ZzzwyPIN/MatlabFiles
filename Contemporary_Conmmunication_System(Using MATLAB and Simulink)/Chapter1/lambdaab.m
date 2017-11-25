function y=lambdaab(x,a,b)
% y=lambdaab(x) 	triangular function of width 2b centered at a (b>0)
%			
y=(x/b+(b-a)/b).*((x>(a-b)) & (x<a))+(-x/b+(a+b)/b).*((x>=a) & (x<(a+b)));