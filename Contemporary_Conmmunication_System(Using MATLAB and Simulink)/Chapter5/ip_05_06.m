% MATLAB script for Illustrative Problem 5.6. 
clc
clear

echo on
SNRindB1=0:1:15;
SNRindB2=0:0.1:15;
smld_err_prb=zeros(1,length(SNRindB1));
for i=1:length(SNRindB1)
   smld_err_prb(i)=Smldpe56(SNRindB1(i));   	% simulated error rate
   echo off;
end;
echo on;
theo_err_prb=zeros(1,length(SNRindB2));
for i=1:length(SNRindB2)
   SNR=exp(SNRindB2(i)*log(10)/10);         	% signal-to-noise ratio
   theo_err_prb(i)=Qfunct(sqrt(SNR/2));  	% theoretical error rate
   echo off;
end;
echo on;
% Plotting commands follow.
semilogy(SNRindB1,smld_err_prb,'*');
hold
semilogy(SNRindB2,theo_err_prb);