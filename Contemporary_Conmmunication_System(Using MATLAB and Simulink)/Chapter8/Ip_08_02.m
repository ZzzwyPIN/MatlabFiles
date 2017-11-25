% MATLAB script for Illustrative Problem 8.2.
echo on
pn0_db=[-20:0.1:30];
pn0=10.^(pn0_db./10);
capacity=3000.*log2(1+pn0/3000);
pause % Press a key to see a plot of channel capacity vs. P/N0.
clf
semilogx(pn0,capacity)
title('Capacity vs. P/N0 in an AWGN channel')
xlabel('P/N0')
ylabel('Capacity (bits/second)')
clear
w=[1:10,12:2:100,105:5:500,510:10:5000,5025:25:20000,20050:50:100000];
pn0_db=25;
pn0=10^(pn0_db/10);
capacity=w.*log2(1+pn0./w);
pause % Press a key to see a plot of channel capacity vs. bandwidth.
clf
semilogx(w,capacity)
title('Capacity vs. bandwidth in an AWGN channel')
xlabel('Bandwidth (Hz)')
ylabel('Capacity (bits/second)')
