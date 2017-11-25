function dist=uq_mdpnt(funfcn,b,n,delta,tol,p1,p2,p3)
%UQ_MDPNT 	returns the distortion of a uniform quantizer
% 	  	with quantization points set to the midpoints
%	  	DIST=UQ_MDPNT(FUNFCN,B,N,DELTA,TOL,P1,P2,P3).
%	  	funfcn=source density function given in an m-file 
%	  	with at most three parameters, p1,p2,p3. The density
%	  	function is assumed to be an even function.
%	  	[-b,b]=the support of the source density function.
%	  	n=number of levels.
% 	  	delta=level size.
% 	  	p1,p2,p3=parameters of the input function.
%	  	dist=distortion.
%	  	tol=the relative error.

if (2*b<delta*(n-1))
  error('Too many levels for this range.'); return
end
args=[];
for j=1:nargin-5
  args=[args,',p',int2str(j)];
end
args=[args,')'];
a(1)=-b;
a(n+1)=b;
a(2)=-(n/2-1)*delta;
y(1)=a(2)-delta/2;
for i=3:n
  a(i)=a(i-1)+delta;
  y(i-1)=a(i)-delta/2;
end
y(n)=a(n)+delta;
dist=0;
for i=1:n
  newfun = 'x_a2_fnct' ;
  dist=dist+eval(['quad(newfun,a(i),a(i+1),tol,[],funfcn,', num2str(y(i)), args]);
end
