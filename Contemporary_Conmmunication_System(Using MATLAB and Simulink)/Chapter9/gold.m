% Gold�����ǻ���m������ѡ�Բ����ģ���������������ͬ��������ͬ��
% �����ֲ�ͬ��m������ѡ��ģ2�Ӻ�õ��ģ�
% һ�Գ���ΪN��m������ѡ�Կ��Բ���N��2��Gold�롣
clear
clc
%%%%%%GOLD���е�����%%%%%%
r=6;N=2^r-1;    
s1(1:6)=[1 0 0 0 0 0];                       %initial value 1
s2(1:6)=[1 0 0 0 0 0];                       %initial value 1
f1=[1  0 0 0  0 1 1];                       %��������ʽf��x^6+x+1;
f2=[1  1 0 0  1 1 1];                       %��������ʽf��x^6+x^5+x^2+x+1;
for n=r+1:N                                %creat pn 1
    s1(n)=mod(sum(s1(n-r:n-1).*f1(1:r)),2);
end
for n=r+1:N                                %creat pn 2
    s2(n)=mod(sum(s2(n-r:n-1).*f2(1:r)),2);
end
s=mod(s1+s2,2); %creat pn gold
gold_sequence_1 = s;
