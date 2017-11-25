% il3_8fun.m 

function f=il3_8fun(x,p)
f=1/sqrt(2*pi)*exp((-(x-p).^2)/2).*log2(2./(1+exp(-2*x.*p)));
