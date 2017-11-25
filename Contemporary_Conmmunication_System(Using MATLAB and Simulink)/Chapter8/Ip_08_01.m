% MATLAB script for Illustrative Problem 8.1. 
echo on
gamma_db=[-20:0.1:20];
gamma=10.^(gamma_db./10);
p_error=q(sqrt(2.*gamma));
capacity=1.-entropy2(p_error);
pause % Press a key to see a plot of error probability vs. SNR/bit.
clf
semilogx(gamma,p_error)
xlabel('SNR/bit')
title('Error probability versus SNR/bit')
ylabel('Error Prob.')
pause % Press a key to see a plot of channel capacity vs. SNR/bit.
clf
semilogx(gamma,capacity)
xlabel('SNR/bit')
title('Channel capacity versus SNR/bit')
ylabel('Channel capacity')
