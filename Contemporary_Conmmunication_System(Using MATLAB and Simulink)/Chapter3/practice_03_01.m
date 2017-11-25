clc
clear

fc=25;
df=0.3;
t0=2;
ts=0.002;
fs=1/ts;
t=0:ts:t0;

%��Ϣ�źŵ�¼��
m=zeros(size(t));
m(1:49)=0.1;
m(50:499)=t(50:499);
m(500:949)=-t(500:949)+2;
m(950:1001)=0.1;

c=cos(2*pi*fc.*t);  %�����ز��źš�
u=m.*c;             %�ѵ��źš�

[M,m,df1]=Fftseq(m,ts,df); %#ok<*ASGLU>
M=M/fs;

[U,u,df1]=Fftseq(u,ts,df);
U=U/fs;

signal_power=spower(u(1:length(t)));    %�ѵ��źŵĹ��ʡ�

f=(0:df1:df1*(length(M)-1))-fs/2;

N=50;
Mx=Rx_est(m,N);
Smx=fftshift(abs(fft(Mx)));
figure
subplot(1,2,1)
plot(Mx);
title('��Ϣ�ź�����غ���')
subplot(1,2,2)
plot(Smx);
title('��Ϣ�źŹ�����')

Ux=Rx_est(u,N);
Sux=fftshift(abs(fft(Ux)));
figure
subplot(1,2,1)
plot(Mx);
title('�ѵ��ź�����غ���')
subplot(1,2,2)
plot(Sux);
title('�ѵ��źŹ�����')

figure
subplot(1,2,1)
plot(Smx);
title('��Ϣ�źŹ�����');
subplot(1,2,2)
plot(Sux);
title('�ѵ��źŹ�����')

figure
subplot(2,1,1)
plot(t,m(1:length(t)))
title('��Ϣ�ź�');
xlabel('t')
ylabel('m(t)');
subplot(2,1,2)
plot(t,u(1:length(t)));
title('�ѵ��ź�');
xlabel('t')
ylabel('u(t)');

figure
subplot(2,1,1)
plot(f,fftshift(abs(M)));
title('��Ϣ�ź�Ƶ��');
xlabel('f')
ylabel('M(f)');

subplot(2,1,2)
plot(f,fftshift(abs(U)));
title('�ѵ��ź�Ƶ��');
xlabel('f')
ylabel('U(f)');

