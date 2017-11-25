function y=Centroid(funfcn,a,b,tol,p1,p2,p3)
% CENTROID	Finds the centroid of a function over a region.
% 		Y=CENTROID('F',A,B,TOL,P1,P2,P3) finds the centroid of the
% 		function F defined in an m-file on the [A,B] region. The
% 		function can contain up to three parameters, P1, P2, P3.
%		tol=the relative error.

args=[];
for n=1:nargin-4
  args=[args,',p',int2str(n)];
end
args=[args,')'];
funfcn1='x_fnct';
y1=eval(['quad(funfcn1,a,b,tol,[],funfcn',args]);
y2=eval(['quad(funfcn,a,b,tol,[]',args]);
y=y1/y2;
