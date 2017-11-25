% MATLAB script that generates the probability of error versus the signal to noise ratio.
initial_snr=0;
final_snr=12;
snr_step=0.75;			
tolerance=eps;			   	% Tolerance used for the integration
plus_inf=20;			   	% This is practically infinity
snr_in_dB=initial_snr:snr_step:final_snr;
for i=1:length(snr_in_dB),
   snr=10^(snr_in_dB(i)/10);
   Pe_2(i)=1-quad8('bdt_int2',0,plus_inf,tolerance,[],snr,2);
   Pe_4(i)=1-quad8('bdt_int2',0,plus_inf,tolerance,[],snr,4);
   Pe_8(i)=1-quad8('bdt_int2',0,plus_inf,tolerance,[],snr,8);
   Pe_16(i)=1-quad8('bdt_int2',0,plus_inf,tolerance,[],snr,16);
   Pe_32(i)=1-quad8('bdt_int2',0,plus_inf,tolerance,[],snr,32);
   echo off;
end;
% Plotting commands follow后为自加上的
semilogy(snr_in_dB,Pe_2);
hold on
semilogy(snr_in_dB,Pe_4);
semilogy(snr_in_dB,Pe_8);
semilogy(snr_in_dB,Pe_16);
semilogy(snr_in_dB,Pe_32);
hold off