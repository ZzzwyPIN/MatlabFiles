function v=variance(funfcn,a,b,tol,p1,p2,p3)
% EXPECTED Finds the variance of a random variable 
%	   with probability density function 'funfcn' and 
%	   support [a,b].
% 	   Y=VARIANCE('F',A,B,TOL,P1,P2,P3), finds the variance 
% 	   of the density function F defined in an m-file. The
% 	   function can contain up to three parameters,P1,P2,P3.
%	   tol=the relative error.

args=[];
for n=1:nargin-4
  args=[args,',p',int2str(n)];
end
args=[args,')'];
funfcn1=['x.*',funfcn];
e=eval(['quad(funfcn1,a,b,tol,[]',args]);
newfun=['(x-(',num2str(e),')).^2.*',funfcn];
v=eval(['quad(newfun,a,b,tol,[]',args]);
