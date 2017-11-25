% MATLAB script for Illustrative Problem 
echo on
rho_b=0:2:24;				% rho in dB
for i=1:length(rho_b)
  smld_err_prb(i)=ss_Pe42(rho_b(i));  	% simulated error rate
end;
% Plotting commands follow