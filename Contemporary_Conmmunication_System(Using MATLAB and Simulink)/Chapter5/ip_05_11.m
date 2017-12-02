% MATLAB script for Illustrative Problem 5.11.
echo on
SNRindB=0:2:10;	  		     	
for i=1:length(SNRindB)
  % simulated error rate
  smld_err_prb(i)=smldp511(SNRindB(i));
  echo off;
end;
echo on ;
% Plotting commands follow.后为自加上的
semilogy(SNRindB,smld_err_prb,'*');
snr_in_dB=0:0.5:10;
tolerance=eps;
plus_inf=20;
for i=1:length(snr_in_dB)
    snr=10^(snr_in_dB(i)/10);
    Pe_4(i)=1-quad('Bdt_int2',0,plus_inf,tolerance,[],snr,4);
end
hold on
semilogy(snr_in_dB,Pe_4);
hold off