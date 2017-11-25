function x=Invmulaw(y,mu)
%INVMULAW		the inverse of mu-law nonlinearity
%X=INVMULAW(Y,MU)	Y=normalized output of the mu-law nonlinearity.

x=(((1+mu).^(abs(y))-1)./mu).*signum(y);
