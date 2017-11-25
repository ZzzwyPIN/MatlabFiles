clc
clear
x=-20:0.01:20;
m=0;s=1;
y=(1/sqrt(2*pi*s^2))*exp(-((x-m).^2)/(2*s^2));
plot(x,y);
axis([-20 20 0 0.5]);