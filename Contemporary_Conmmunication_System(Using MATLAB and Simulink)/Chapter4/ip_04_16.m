clc
clear

n=64;
a=[20*randn(1,20) randn(1,480)];
[sqnr,a_quan,code]=U_pcm(a,n);

[musqnr,mua_quan,mucode]=Mula_pcm(a,n,255);
