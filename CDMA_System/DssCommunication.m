clc
clear

Y=30;
errors=zeros(1,Y);
for K=1:Y %K��ʾ�û�������
%.....����K���û���Ƶ��......%
pntaps1=[1 0 0 0 0 1];%��ԭ����ʽ1
pntaps2=[1 1 0 0 1 1];%��ԭ����ʽ2����������ֻ��������ԭ����ʽ��������M������ѡ��
pninitial=[ 0 0 0 0 0 1];%��ʼ����λ�Ĵ���
C=zeros(30,63);%Ԥ�����ڴ���Gold��
%����K��Gold��
for i=1:K
    feedback=rem((pninitial*pntaps1'),2);
    pninitial=[feedback,pninitial(1,1:length(pntaps1)-1)];
    C(i,:)=goldPN(pntaps1,pntaps2,pninitial);
end;

C=2*C-1;%����Ƶ��ӳ���˫������
N=2^length(pntaps1)-1;
M=10000;%����ÿ���û�������Ϣ����λ��
B=2*randi([0,1],K,M)-ones(K,M);%��������û�������Ϣ����ӳ���˫������

A=zeros(1,N*M);
%��Ƶ
 for i=1:K
        for j=1:M
            A((j-1)*N+1:j*N)=B(i,j)*C(i,:)+A((j-1)*N+1:j*N); %ÿ���û���m*N��Ƶ������ۼӵ�ͬһm*N��(�����ŵ�)
        end
 end
A=reshape(A,N,M);%��������Ϊ����

%noise_power=10*log10(N)-SNR;
SNR=3;
D=awgn(A,SNR,'measured');%�������

b=C*D;%����


errors(1,K)=countError(b,B,K,M);%ͳ���������
end;
%��ͼ
users=1:K;
semilogy(users,errors,'b-+');
title('�����һ��ʱ,�û����������ʵĹ�ϵ');
xlabel('�û���K');
ylabel('�������BER');


            

