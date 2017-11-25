clc
clear
ts=0.001;fs=1/ts;
N=1024;
t=0:ts:10;
x=cos(2*pi*47*t)+cos(2*pi*219*t);
p1=norm(x);%norm(x)的意思是？
p2=p1^2;
p=p2/length(x);
subplot(2,1,1)
plot(t,x)
title('信号')
xlabel('时间');ylabel('幅度');
grid on;
window=boxcar(length(x));
[Pxx,f]=periodogram(x,window,N,fs);
subplot(2,1,2);
plot(f,Pxx);
grid on;
title(['周期图法估计功率谱，',int2str(N),'点']);
xlabel('频率');
ylabel('功率谱密度');


