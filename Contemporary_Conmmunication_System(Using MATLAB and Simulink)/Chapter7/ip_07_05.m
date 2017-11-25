% MATLAB script for Illustrative Problem 7.5.
echo on
SNRindB1=0:2:12;
SNRindB2=0:0.1:12;
for i=1:length(SNRindB1),
  smld_err_prb(i)=cm_sm34(SNRindB1(i));	% simulated error rate
  echo off ;
end;
echo on ;
for i=1:length(SNRindB2),
  SNR=exp(SNRindB2(i)*log(10)/10);   	% signal-to-noise ratio
  theo_err_prb(i)=2*Qfunct(sqrt(SNR)); 	% theoretical symbol error rate
  echo off ;
end;		
echo on ;			    
% Plotting commands follow
semilogy(SNRindB1,smld_err_prb,'*');
hold
semilogy(SNRindB2,theo_err_prb);