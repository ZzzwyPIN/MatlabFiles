% MATLAB script for Illustrative Problem 9.6.
echo on
rho_b1=0:5:35;	           		% rho in dB for the simulated error rate 
rho_b2=0:0.1:35; 	   		% rho in dB for theoretical error rate computation
for i=1:length(rho_b1),
  smld_err_prb(i)=ss_pe96(rho_b1(i));	% simulated error rate
  echo off ;
end;
echo on ;
for i=1:length(rho_b2),
  temp=10^(rho_b2(i)/10);	
  if (temp>2)
    theo_err_rate(i)=1/(exp(1)*temp);	% theoretical error rate if rho>2
  else
    theo_err_rate(i)=(1/2)*exp(-temp/2);% theoretical error rate if rho<2
  end;
  echo off ;
end;
echo on ;
% Plotting commands follow.