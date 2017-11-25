% MATLAB script for Illustrative Problem 5.1. 
df=0.01;
fs=10;
ts=1/fs;%����1.6��֪Ϊʲô�������ȡ0.1
t=[-5:ts:5];
x1=zeros(size(t));%x1Ϊ��tһ���������飬����ÿ��Ԫ�ؾ�Ϊ0
x1(41:51)=t(41:51)+1;
x1(52:61)=ones(size(x1(52:61)));
x2=zeros(size(t));
x2(51:71)=x1(41:61);
figure
subplot(1,2,1)
stem(t,x1);
axis([-2 2 0 1]);
title('x1(t)�����ź�');
subplot(1,2,2)
stem(t,x2);
axis([-1 3 0 1]);
title('x2(t)�����ź�');
[X1,x11,df1]=Fftseq(x1,ts,df);%�ܷ�ֱ����FFT��������Fftseq������
[X2,x21,df2]=Fftseq(x2,ts,df);
X11=X1/fs;%ΪʲôҪ����fs?��1.6֪���������ű�����
X21=X2/fs;
f=[0:df1:df1*(length(x11)-1)]-fs/2;
figure
plot(f,fftshift(abs(X21)))
title('�ź�x1(t)��x2(t)�ķ�����');
figure
plot(f(500:525),fftshift(angle(X11(500:525))),f(500:525),fftshift(angle(X21(500:525))),'--')
title('�ź�x1(t)��x2(t)����λ��');
text(-0.02,3,'X1(f)');
text(0.08,3,'X2(f)');
