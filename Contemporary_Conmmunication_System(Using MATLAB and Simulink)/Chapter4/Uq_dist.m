function [y,dist]=Uq_dist(funfcn,b,c,n,delta,s,tol,p1,p2,p3)
%UQ_DIST 	returns the distortion of a uniform quantizer
% 	 	with quantization points set to the centroids
%	 	[Y,DIST]=UQ_DIST(FUNFCN,B,C,N,DELTA,S,TOL,P1,P2,P3)
%	 	funfcn=source density function given in an m-file 
%	 	with at most three parameters, p1,p2,p3.
%	 	[b,c]=The support of the source density function.
%	 	n=number of levels.
% 	 	delta=level size.
%	 	s=the leftmost quantization region boundary.
% 	 	p1,p2,p3=parameters of the input function.
%	 	y=quantization levels.
%	 	dist=distortion.
%	 	tol=the relative error.

if (c-b<delta*(n-2))
  error('Too many levels for this range.'); return
end
if (s<b)
  error('The leftmost boundary too small.'); return
end
if (s+(n-2)*delta>c)
  error('The leftmost boundary too large.'); return
end
args=[];
for j=1:nargin-7
  args=[args,',p',int2str(j)];
end
args=[args,')'];
a(1)=b;
for i=2:n
  a(i)=s+(i-2)*delta;
end
a(n+1)=c;
[y,dist]=eval(['Mse_dist(funfcn,a,tol',args]);
