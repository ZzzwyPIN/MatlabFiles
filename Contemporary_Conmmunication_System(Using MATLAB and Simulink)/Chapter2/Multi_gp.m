function [x] = Multi_gp(m,C)
%  [x]=multi_gp(m,C)
%		MULTI_GP  generates a multivariate Gaussian random
%   		process with mean vector m (column vector) and covariance matrix C.
N=length(m);
for i=1:N           			
  y(i)=Gngauss;      			
end;
y=y.';               			
x=sqrtm(C)*y+m;      			