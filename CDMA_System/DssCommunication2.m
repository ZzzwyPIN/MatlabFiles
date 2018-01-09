clc
clear

K=30; %K��ʾ�û�������
%.....����K���û���Ƶ��......%
pntaps1=[1 0 0 0 0 1];
pntaps2=[1 1 0 0 1 1];
pninitial=[ 0 0 0 0 0 1];
C=zeros(30,63);
for i=1:K
    feedback=rem((pninitial*pntaps1'),2);
    pninitial=[feedback,pninitial(1,1:length(pntaps1)-1)];
    C(i,:)=goldPN(pntaps1,pntaps2,pninitial);
end;

C=2*C-1;
r=zeros(30,30);
for i=1:30
    for j=1:30
        r(i,j)=C(i,:)*C(j,:)';
    end
end
N=2^length(pntaps1)-1;
M=10000;
B=2*randi([0,1],K,M)-ones(K,M);

A=zeros(1,N*M);
 for i=1:K
        for j=1:M
            A((j-1)*N+1:j*N)=B(i,j)*C(i,:)+A((j-1)*N+1:j*N); %ÿ���û���m*N��Ƶ������ۼӵ�ͬһm*N��(�����ŵ�)
        end
 end
A=reshape(A,N,M);
for SNRindB=0:12


D=awgn(A,SNRindB,'measured');
b=C*D;

errors(SNRindB+1)=countError(b,B,K,M);
end;

snr=0:12;
semilogy(snr,errors,'b-+');
title('�û���һ��ʱ,����Ⱥ������ʵĹ�ϵ');
xlabel('�����(dB)');
ylabel('�������BER');


            

