function e=expected(funfcn,a,b,tol,p1,p2,p3)
% EXPECTED Finds the expected value of a random variable 
%	   with probability density function 'funfcn' and 
%	   support [a,b].
% 	   Y=EXPECTED('F',A,B,TOL,P1,P2,P3), finds the expected 
% 	   value of the function F defined in an m-file. The
% 	   function can contain up to three parameters,P1,P2,P3.
%	   tol=the relative error.

args=[];
for n=1:nargin-4
  args=[args,',p',int2str(n)];
end
args=[args,')'];
funfcn1=['x.*',funfcn];
e=eval(['quad(funfcn1,a,b,tol,[]',args]);
