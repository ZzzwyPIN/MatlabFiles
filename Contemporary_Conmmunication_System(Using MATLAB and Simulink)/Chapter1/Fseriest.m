function xx=fseriest(funfcn,t,n,tol,p1,p2,p3)
%FSERIEST 	Returns the Fourier series coefficients.
%	  	XX=FSERIEST(FUNFCN,T,N,TOL,P1,P2,P3)
%	  	funfcn=The given function in an m-file.
%	  	It can depend on up to three parameters
%	  	p1,p2, and p3. The function is given
%	  	over one period.
%	  	t=the period.
%	  	n=the number of coefficients returned.
%	  	p1,p2,p3=parameters of funfcn. 
%	  	tol=the error level.

xx=fseries(funfcn,0,t,n,tol,p1,p2,p3);