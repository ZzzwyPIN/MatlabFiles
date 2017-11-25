% MATLAB script that generates the probability of error versus the signal-to-noise ratio
initial_snr=0;
final_snr=15;
snr_step=1;			
tolerance=1e-7;			   	% tolerance used for the integration
minus_inf=-20;			   	% This is practically negative infinity.
plus_inf=20;			   	% This is practically infinity.
snr_in_dB=initial_snr:snr_step:final_snr;
for i=1:length(snr_in_dB),
   snr=10^(snr_in_dB(i)/10);
   Pe_2(i)=Qfunct(sqrt(snr));
   Pe_4(i)=(2/3)*quad8('bdt_int',minus_inf,plus_inf,tolerance,[],snr,4);
   Pe_8(i)=(4/7)*quad8('bdt_int',minus_inf,plus_inf,tolerance,[],snr,8);
   Pe_16(i)=(8/15)*quad8('bdt_int',minus_inf,plus_inf,tolerance,[],snr,16);
   Pe_32(i)=(16/31)*quad8('bdt_int',minus_inf,plus_inf,tolerance,[],snr,32);
   Pe_64(i)=(32/63)*quad8('bdt_int',minus_inf,plus_inf,tolerance,[],snr,64);
end;
% Plotting commands follow.后为自加上的
semilogy(snr_in_dB,Pe_2);
hold on
semilogy(snr_in_dB,Pe_4);
semilogy(snr_in_dB,Pe_8);
semilogy(snr_in_dB,Pe_16);
semilogy(snr_in_dB,Pe_32);
semilogy(snr_in_dB,Pe_64);
hold off