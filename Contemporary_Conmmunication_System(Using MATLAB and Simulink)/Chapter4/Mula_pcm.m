function [sqnr,a_quan,code]=Mula_pcm(a,n,mu)
%MULA_PCM 	mu-law PCM encoding of a sequence
%       	[SQNR,A_QUAN,CODE]=MULA_PCM(A,N,MU).
%       	a=input sequence.
%       	n=number of quantization levels (even).
%       	sqnr=output SQNR (in dB).
%		a_quan=quantized output before encoding.
%		code=the encoded output.

[y,maximum]=Mulaw(a,mu);
[~,y_q,code]=U_pcm(y,n);
a_quan=Invmulaw(y_q,mu);
a_quan=maximum*a_quan;
sqnr=20*log10(norm(a)/norm(a-a_quan));


