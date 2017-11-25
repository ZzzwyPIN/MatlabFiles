clc
clear
ts=0.001;
df=0.5;
fs=1/ts;
t=-2:ts:2;
x=(sinc(100*t)).*cos(2*pi*200*t);
%����ԭ�ź�x(t)
figure
plot(t,x);
axis([-2 2 -0.8 1]);
xlabel('t');

%��ԭ�źŵķ�����
[X1,x1,df1]=Fftseq(x,ts,df);
X11=X1/fs;
f1=[0:df1:df1*(length(x1)-1)]-fs/2; 
figure
plot(f1,fftshift(abs(X11)));
axis([-500 500 0 6*10^-3]);
xlabel('f');

%��f0=200Hz��x(t)�ĵ�ͨ��Ч�����������ķ�����
f0=200;
xl=Loweq(x,ts,f0);
[XL2,xl2,df2]=Fftseq(xl,ts,df);
XL22=XL2/fs;
f2=(0:df2:df2*(length(xl2)-1))-fs/2;
figure
plot(f2,fftshift(abs(XL22)));
xlabel('f');

%��f0=200Hz�������źŵ�ͬ������Լ�����
[xc1,xs1]=Quadcomp(x,ts,200);
figure
subplot(1,2,1)
plot(t,xc1);
axis([-2 2 -0.4 1]);
subplot(1,2,2)
plot(t,abs(xc1));
axis([-2 2 0 1]);

%%��f0=100Hz��x(t)�ĵ�ͨ��Ч�����������ķ�����
xll=Loweq(x,ts,100);
[XLL2,xll2,df3]=Fftseq(xll,ts,df);
XLL22=XLL2/fs;
f3=(0:df3:df3*(length(xl2)-1))-fs/2;
figure
plot(f3,fftshift(abs(XLL22)));
xlabel('f');

%��f0=100Hz�������źŵ�ͬ������Լ�����
[xc2,xs2]=Quadcomp(x,ts,100);
figure
subplot(1,2,1)
plot(t,xc2);
axis([-2 2 -0.8 1]);
subplot(1,2,2)
plot(t,abs(xc2));
axis([-2 2 0 1]);





