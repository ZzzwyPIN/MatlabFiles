% MATLAB script for Illustrative Problem 6.1.
echo on
T=1;
delta_f=1/(100*T);		
f=-5/T:delta_f:5/T;
sgma_a=1;
Sv=sgma_a^2*sinc(f*T).^2;
% Plotting command follows.
plot(f,Sv);
