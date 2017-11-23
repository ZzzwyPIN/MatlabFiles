%初始化
clc
clear

[y,fs]=audioread('成都.mp3');%抽取声音信号
%sound(y,fs);
y_left=y(:,1);%抽取左声道声音信号

%画出原始信号图，从10000-10256显示256个点
% figure
% plot(y_left(8000000:8001024));
% title('原声音信号');

N=length(y_left);%记录音频信号长度

h=wfilters('db5','l');%调用wfilters函数生成小波滤波器。'l'表示返回低通滤波器，'db4'表示采用db4小波。
g=wfilters('db5','h');%调用wfilters函数生成小波滤波器。'h'表示返回高通滤波器，'db4'表示采用db4小波。
h=[h,zeros(1,N-length(h))];%对生成的低通滤波器进行补零，使之长度与音频信号相等。
g=[g,zeros(1,N-length(g))];

% figure
% stem(abs(fft(h)));
% title('低通滤波器图');
% % 
% figure
% stem(abs(fft(g)));
% title('高通滤波器图');

sig1=ifft(fft(y_left').*fft(h));%生成一层近似信号
sig2=ifft(fft(y_left').*fft(g));%生成一层细节信号



sig3=ifft(fft(sig1).*fft(h));%生成二层近似信号
sig4=ifft(fft(sig1).*fft(g));%生成二层细节信号



%重构低通滤波器。因重构时丢弃高频信号，故不需要重构高通滤波器。
hr=h(end:-1:1);
% figure
% subplot(2,1,1)
% stem(abs(fft(h)));
% title('低通滤波器图');
% subplot(2,1,2)
% stem(abs(fft(hr)));
% title('重构低通滤波器图');


Ysig=dyaddown(sig3);%对二层近似信号进行2抽取
Rsig=dyadup(Ysig);%2插零
Rsig3=ifft(fft(hr).*fft(Rsig));%重构一层近似信号。丢弃二层高频系数。

% figure
% subplot(2,1,1)
% plot(sig1(8000000:8001024));
% title('一层近似信号');
% subplot(2,1,2)
% plot(Rsig3(8000000:8001024));
% title('重构一层近似信号');


%重构原始信号，丢弃一层高频系数。
Ysig1=dyaddown(Rsig3);
Rsig1=dyadup(Ysig1);
Rin=ifft(fft(hr).*fft(Rsig1));
% sound(in,fs);

figure
subplot(2,1,1)
plot(y_left(8000000:8001024));
title('原声音信号');
subplot(2,1,2)
plot(Rin(8000000:8001024));
title('重构原声音信号');

%生成重构过后的音频文件。
% str='成都_重构.wav';
% audiowrite(str,Rin,fs);
    
    
