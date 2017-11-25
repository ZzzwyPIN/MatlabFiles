% MATLAB scripit for Illustrative Problem 9.7.
echo on
rho_b=0:2:24;                         	% rho in dB
for i=1:length(rho_b),
  smld_err_prb(i)=ss_Pe97(rho_b(i));   	% simulated error rate
  echo off ;
end;
echo on ;
% Plotting commands follow.