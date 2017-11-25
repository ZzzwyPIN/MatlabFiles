% The function needed in Illustrative Problem 8, Chapter 4. 

function f=il4_8fun(x,p)
f=1/sqrt(2*pi)*exp((-(x-p).^2)/2).*log2(2./(1+exp(-2*x.*p)));
