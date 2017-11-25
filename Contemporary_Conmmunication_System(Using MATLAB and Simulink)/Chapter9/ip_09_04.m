% MATLAB script for Illustrative Problem 9.4.
clc
clear

echo on
Lc=20;			  		% number of chips per bit
A1=3;			  		% amplitude of the first sinusoidal interference
A2=7;			  		% amplitude of the second sinusoidal interference
A3=12;			  		% amplitude of the third sinusoidal interference
A4=0;			  		% fourth case: no interference
w0=1;			  		% frequency of the sinusoidal interference in radians
SNRindB=0:2:30;
for i=1:length(SNRindB)
  % measured error rates
  smld_err_prb1(i)=Ss_pe94(SNRindB(i),Lc,A1,w0);
  smld_err_prb2(i)=Ss_pe94(SNRindB(i),Lc,A2,w0);
  smld_err_prb3(i)=Ss_pe94(SNRindB(i),Lc,A3,w0);
  echo off ;
end;
echo on ;
SNRindB4=0:1:8;
for i=1:length(SNRindB4)
  % measured error rate when there is no interference
  smld_err_prb4(i)=Ss_pe94(SNRindB4(i),Lc,A4,w0); 
  echo off ;
end;    	
echo on ;		          
% Plotting commands follow.
semilogy(SNRindB,smld_err_prb1,'k-o',SNRindB,smld_err_prb2,'k-o',SNRindB,smld_err_prb3,'k-o');
hold on ;semilogy(SNRindB4,smld_err_prb4,'k-o');
