function [y,dist]=Mse_dist(funfcn,a,tol,p1,p2,p3)
%MSE_DIST 	Returns the mean-squared quantization error.
%         	[Y,DIST]=MSE_DIST(FUNFCN,A,TOL,P1,P2,P3)     
% 	  	funfcn=The distribution function given 
%	  	in an m-file. It can depend on up to three 
%	  	parameters, p1,p2,p3.
% 	  	a=the vector defining the boundaries of the 
%	  	quantization regions. (Note: [a(1),a(length(a))] 
%	  	is the support of funfcn.)
% 	  	p1,p2,p3=parameters of funfcn.
%	  	tol=the relative error.

args=[];
for n=1:nargin-3
  args=[args,',p',int2str(n)];
end
args=[args,')'];
for i=1:length(a)-1
  y(i)=eval(['Centroid(funfcn,a(i),a(i+1),tol',args]);
end
dist=0;
for i=1:length(a)-1
  newfun = 'x_a2_fnct' ;
  dist=dist+eval(['quad(newfun,a(i),a(i+1),tol,[],funfcn,', num2str(y(i)), args]);
end
