% script that generates the figure 3.4 of Carrier modulation chapter
snrindB=0:0.25:18;
for i=1:length(snrindB),
  snr=10^(0.1*snrindB(i));
  P2(i)=Qfunct(sqrt(2*snr));
  P4(i)=2*Qfunct(sqrt(4*snr)*sin(pi/4));
  P8(i)=2*Qfunct(sqrt(6*snr)*sin(pi/8));
  P16(i)=2*Qfunct(sqrt(8*snr)*sin(pi/16));
end;