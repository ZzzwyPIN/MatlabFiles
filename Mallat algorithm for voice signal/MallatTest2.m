clc
clear


[y, fs] = audioread('�ɶ�.mp3'); %����Ƶ�ļ�ת��Ϊ������ʽ
y_left = y(:,1);%���������������ź�
% N = length(y_left);%��¼��Ƶ�źų���

[C,L]=wavedec(y_left,3,'db5');
% [cD1, cD2, cD3]=detcoef(C,L,[1,2,3]);%�ӷֽ�ϵ����[c l]����ȡ��һ�㡢�ڶ��㡢�������Ƶϵ��
cA3=appcoef(C,L,'db5',3);%�ӷֽ�ϵ��[c l]�������3�����ϵ��

%������ĸ�Ƶϵ��ֱ�����㡣
% cD3=0*cD3;
% cD2=0*cD2;
% cD1=0*cD1;
% 
% %����idwt�������źŽ����ع���
% cA2=idwt(cA3,cD3,'db5');
% cA1=idwt(cA2,cD2,'db5');
% out=idwt(cA1,cD1,'db5');

%�����ع��źź�ԭʼ�źŶԱ�ͼ��
% figure
% subplot(2,1,1)
% plot(y_left(8000000:8001024));
% title('ԭʼ�����ź�')
% subplot(2,1,2)
% plot(out(8000000:8001024));
% title('�ع������ź�')

% str='R_chengdu.wav';
% audiowrite(str,out,fs);









