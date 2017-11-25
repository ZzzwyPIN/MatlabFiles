% MATLAB script for Illustrative Problem 7.6.
echo on
SNRindB1=0:2:15;
SNRindB2=0:0.1:15;
M=16;
k=log2(M);
for i=1:length(SNRindB1),
  smld_err_prb(i)=cm_sm41(SNRindB1(i));	% simulated error rate
  echo off;
end;
echo on ;
for i=1:length(SNRindB2),
  SNR=exp(SNRindB2(i)*log(10)/10);    	% signal-to-noise ratio
  % theoretical symbol error rate
  theo_err_prb(i)=4*Qfunct(sqrt(3*k*SNR/(M-1)));  
  echo off ;
end;
echo on ;
% Plotting commands follow.
semilogy(SNRindB1,smld_err_prb,'*');
hold
semilogy(SNRindB2,theo_err_prb);