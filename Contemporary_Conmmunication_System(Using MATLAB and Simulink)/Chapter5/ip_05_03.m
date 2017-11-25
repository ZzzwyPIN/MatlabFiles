% The MATLAB script that generates the probability of error versus the signal-to-noise ratio.
initial_snr=0;
final_snr=15;
snr_step=0.25; 				
snr_in_dB=initial_snr:snr_step:final_snr;
for i=1:length(snr_in_dB),
  snr=10^(snr_in_dB(i)/10);	        
  Pe(i)=Qfunct(sqrt(snr));	
  echo off;
end;
echo on;
semilogy(snr_in_dB,Pe);