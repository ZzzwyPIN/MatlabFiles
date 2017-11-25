clc
clear


[y, fs] = audioread('成都.mp3'); %将音频文件转化为向量形式
y_left = y(:,1);%分析左声道声音信号
% N = length(y_left);%记录音频信号长度

[C,L]=wavedec(y_left,3,'db5');
% [cD1, cD2, cD3]=detcoef(C,L,[1,2,3]);%从分解系数中[c l]中提取第一层、第二层、第三层高频系数
cA3=appcoef(C,L,'db5',3);%从分解系数[c l]中提起第3层近似系数

%将三层的高频系数直接置零。
% cD3=0*cD3;
% cD2=0*cD2;
% cD1=0*cD1;
% 
% %调用idwt函数对信号进行重构。
% cA2=idwt(cA3,cD3,'db5');
% cA1=idwt(cA2,cD2,'db5');
% out=idwt(cA1,cD1,'db5');

%画出重构信号和原始信号对比图。
% figure
% subplot(2,1,1)
% plot(y_left(8000000:8001024));
% title('原始语音信号')
% subplot(2,1,2)
% plot(out(8000000:8001024));
% title('重构语音信号')

% str='R_chengdu.wav';
% audiowrite(str,out,fs);









