clc
clear
n=-4:0.1:4;
x=zeros(size(n));
x(31:41)=0:0.1:1;
x(41:51)=1:-0.1:0;
figure
stem(n,x);
X=fft(x);
X1=X/40;
X11=fftshift(X1);
figure
stem(n,abs(X11));
title('ÀëÉ¢·ù¶ÈÆ×');
% figure
% stem(n,angle(X1));
% title('ÏàÎ»Æ×');

