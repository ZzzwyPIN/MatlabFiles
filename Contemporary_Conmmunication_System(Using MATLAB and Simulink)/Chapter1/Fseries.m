function xx=fseries(funfcn,a,b,n,tol,p1,p2,p3)
%FSERIES    Returns the Fourier series coefficients.
%       XX=FSERIES(FUNFCN,A,B,N,TOL,P1,P2,P3)
%       funfcn=the given function, in an m-file.
%       It can depend on up to three parameters
%       p1,p2, and p3. The function is given
%       over one period extending from 'a' to 'b'
%       xx=vector of length n+1 of Fourier Series
%       Coefficients, xx0,xx1,...,xxn.
%       p1,p2,p3=parameters of funfcn. 
%       tol=the error level.

j=sqrt(-1);
args0=[];
for nn=1:nargin-5
  args0=[args0,',p',int2str(nn)];
end
args=[args0,')'];
t=b-a;
xx(1)=eval(['1/(',num2str(t),').*quad(funfcn,a,b,tol,[]',args]) ;

for i=1:n
  new_fun = 'exp_fnct' ;
  args=[',', num2str(i), ',', num2str(t), args0, ')' ] ;
  xx(i+1)=eval(['1/(',num2str(t),').*quad(new_fun,a,b,tol,[],funfcn',args]);
end
      
