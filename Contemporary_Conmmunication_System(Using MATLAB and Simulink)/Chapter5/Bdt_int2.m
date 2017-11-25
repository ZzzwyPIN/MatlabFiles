function [y] = bdt_int2(x,snr_per_bit,M)
% [y]=bdt_int2(x,snr_per_bit,M)
%		BDT_INT2   is used to compute the integrand in the expression for
%   		the error probability of biorthogonal signals. 

E=1;
Eb=E/log2(M);
sgma=Eb*sqrt(log2(M)/(2*snr_per_bit));
N=length(x);
for i=1:N,
   y(i)=(1-2*Qfunct(x(i)/sgma))^(M/2-1)*(1/(sqrt(2*pi)*sgma))*exp(-(x(i)-E)^2/(2*sgma^2));
end;