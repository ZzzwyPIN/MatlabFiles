% MATLAB script for Illustrative Problem 4.15

a=randn(1,500);
[dist,a_quan,code]=Mula_pcm(a,16,255);
plot(a-a_quan)
[Y,I]=sort(a);
figure,plot(Y,a_quan(I))