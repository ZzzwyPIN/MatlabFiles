function [a,y,dist]=Lloydmax(funfcn,b,n,tol,p1,p2,p3)
%LLOYDMAX 	returns the the Lloyd-Max quantizer and the mean-squared 
%	  	quantization error for a symmetric distribution
%         	[A,Y,DIST]=LLOYDMAX(FUNFCN,B,N,TOL,P1,P2,P3).     
% 	  	funfcn=The density function given 
%	  	in an m-file. It can depend on up to three 
%	  	parameters, p1,p2,p3.
% 	  	a=the vector giving the boundaries of the 
%	  	quantization regions. 
%	  	[-b,b] approximates support of the density function.
%	  	n=the number of quantization regions.
%	  	y=the quantization levels.
% 	  	p1,p2,p3=parameters of funfcn.
%	  	tol=the relative error.

args=[];
for j=1:nargin-4
  args=[args,',p',int2str(j)];
end
args=[args,')'];
v=eval(['Variance(funfcn,-b,b,tol',args]);
a(1)=-b;
d=2*b/n;
for i=2:n
  a(i)=a(i-1)+d;
end
a(n+1)=b;
dist=v;
[y,newdist]=eval(['Mse_dist(funfcn,a,tol',args]);
while(newdist<0.99*dist)
  for i=2:n
    a(i)=(y(i-1)+y(i))/2;
  end
  dist=newdist;
  [y,newdist]=eval(['Mse_dist(funfcn,a,tol',args]);
end
