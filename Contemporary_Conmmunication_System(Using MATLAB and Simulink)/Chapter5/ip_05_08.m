% MATLAB script for Illustrated Problem 5.8.
 
echo on
SNRindB1=0:1:12;	  		
SNRindB2=0:0.1:12;			
for i=1:length(SNRindB1),
  % simulated error rate 
  smld_err_prb(i)=smldPe58(SNRindB1(i));    
  echo off;
end;
echo on;
for i=1:length(SNRindB2),
  % signal-to-noise ratio
  SNR_per_bit=exp(SNRindB2(i)*log(10)/10);  
  % theoretical error rate
  theo_err_prb(i)=(3/2)*Qfunct(sqrt((4/5)*SNR_per_bit));  
  echo off;
end;
echo on;
% Plotting commands follow.
semilogy(SNRindB1,smld_err_prb,'*');
hold
semilogy(SNRindB2,theo_err_prb);