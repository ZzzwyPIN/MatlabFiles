%��ʼ��
clc
clear

[y,fs]=audioread('�ɶ�.mp3');%��ȡ�����ź�
%sound(y,fs);
y_left=y(:,1);%��ȡ�����������ź�

%����ԭʼ�ź�ͼ����10000-10256��ʾ256����
% figure
% plot(y_left(8000000:8001024));
% title('ԭ�����ź�');

N=length(y_left);%��¼��Ƶ�źų���

h=wfilters('db5','l');%����wfilters��������С���˲�����'l'��ʾ���ص�ͨ�˲�����'db4'��ʾ����db4С����
g=wfilters('db5','h');%����wfilters��������С���˲�����'h'��ʾ���ظ�ͨ�˲�����'db4'��ʾ����db4С����
h=[h,zeros(1,N-length(h))];%�����ɵĵ�ͨ�˲������в��㣬ʹ֮��������Ƶ�ź���ȡ�
g=[g,zeros(1,N-length(g))];

% figure
% stem(abs(fft(h)));
% title('��ͨ�˲���ͼ');
% % 
% figure
% stem(abs(fft(g)));
% title('��ͨ�˲���ͼ');

sig1=ifft(fft(y_left').*fft(h));%����һ������ź�
sig2=ifft(fft(y_left').*fft(g));%����һ��ϸ���ź�



sig3=ifft(fft(sig1).*fft(h));%���ɶ�������ź�
sig4=ifft(fft(sig1).*fft(g));%���ɶ���ϸ���ź�



%�ع���ͨ�˲��������ع�ʱ������Ƶ�źţ��ʲ���Ҫ�ع���ͨ�˲�����
hr=h(end:-1:1);
% figure
% subplot(2,1,1)
% stem(abs(fft(h)));
% title('��ͨ�˲���ͼ');
% subplot(2,1,2)
% stem(abs(fft(hr)));
% title('�ع���ͨ�˲���ͼ');


Ysig=dyaddown(sig3);%�Զ�������źŽ���2��ȡ
Rsig=dyadup(Ysig);%2����
Rsig3=ifft(fft(hr).*fft(Rsig));%�ع�һ������źš����������Ƶϵ����

% figure
% subplot(2,1,1)
% plot(sig1(8000000:8001024));
% title('һ������ź�');
% subplot(2,1,2)
% plot(Rsig3(8000000:8001024));
% title('�ع�һ������ź�');


%�ع�ԭʼ�źţ�����һ���Ƶϵ����
Ysig1=dyaddown(Rsig3);
Rsig1=dyadup(Ysig1);
Rin=ifft(fft(hr).*fft(Rsig1));
% sound(in,fs);

figure
subplot(2,1,1)
plot(y_left(8000000:8001024));
title('ԭ�����ź�');
subplot(2,1,2)
plot(Rin(8000000:8001024));
title('�ع�ԭ�����ź�');

%�����ع��������Ƶ�ļ���
% str='�ɶ�_�ع�.wav';
% audiowrite(str,Rin,fs);
    
    
