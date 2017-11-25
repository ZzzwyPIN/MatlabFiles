clc
clear

a=[20*randn(1,20) randn(1,480)];
code=A_law13code(a);
b=A_law13decode(code);
c=b*max(abs(a));

nq=sum((a-c).*(a-c))/length(a);
sq=mean(c.^2);
snrq=sq/nq;
snrdB=10*log10(snrq);