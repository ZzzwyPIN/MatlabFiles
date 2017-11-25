% MATLAB script for Illustrative Problem 5.9.
echo on
SNRindB1=5:1:25;	  		
SNRindB2=5:0.1:25;			
M=16;
for i=1:length(SNRindB1),
  % simulated error rate
  smld_err_prb(i)=smldPe59(SNRindB1(i));    
  echo off;
end;
echo on ;
for i=1:length(SNRindB2),
  SNR_per_bit=exp(SNRindB2(i)*log(10)/10);  
  % theoretical error rate
  theo_err_prb(i)=(2*(M-1)/M)*Qfunct(sqrt((6*log2(M)/(M^2-1))*SNR_per_bit));
  echo off;
end;
echo on;
% Plotting commands follow.
semilogy(SNRindB1,smld_err_prb,'*');
hold
semilogy(SNRindB2,theo_err_prb);