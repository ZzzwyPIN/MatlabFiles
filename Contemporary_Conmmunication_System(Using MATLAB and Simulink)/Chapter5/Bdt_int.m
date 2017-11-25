function [y] = bdt_int(x,snr_per_bit,M)
% [y]=bdt_int(x,snr_per_bit,M)
%		BDT_INT  is used to compute the integrand needed in the
%   		computaion of the error probability of orthogonal signals 
   		
N=length(x);
for i=1:N,
   y(i)=(1/sqrt(2*pi))*(1-(1-Qfunct(x(i)))^(M-1))*exp(-(x(i)-sqrt(2*log2(M)*snr_per_bit))^2/2);
end;