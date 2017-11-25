% MATLAB script for Illustrative Problem 5.10.
echo on
SNRindB=0:2:10;	  		       	
for i=1:length(SNRindB),
  % simulated error rate
  smld_err_prb(i)=smldP510(SNRindB(i));
  echo off;
end;
echo on;
% Plotting commands follow
semilogy(SNRindB,smld_err_prb,'*');
%后为自加上的
snr_in_dB=0:0.5:10;
tolerance=1e-7;
minus_inf=-20;
plus_inf=20;
for i=1:length(snr_in_dB),
    snr=10^(snr_in_dB(i)/10);
    Pb(i)=(2/3)*quad8('bdt_int',minus_inf,plus_inf,tolerance,[],snr,4);
end
hold on
semilogy(snr_in_dB,Pb)