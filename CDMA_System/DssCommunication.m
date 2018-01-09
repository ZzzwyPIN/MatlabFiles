clc
clear

Y=30;
errors=zeros(1,Y);
for K=1:Y %K表示用户数量。
%.....产生K个用户扩频码......%
pntaps1=[1 0 0 0 0 1];%本原多项式1
pntaps2=[1 1 0 0 1 1];%本原多项式2，查阅资料只这两个本原多项式可以生成M序列优选对
pninitial=[ 0 0 0 0 0 1];%初始化移位寄存器
C=zeros(30,63);%预分配内存存放Gold码
%生成K个Gold码
for i=1:K
    feedback=rem((pninitial*pntaps1'),2);
    pninitial=[feedback,pninitial(1,1:length(pntaps1)-1)];
    C(i,:)=goldPN(pntaps1,pntaps2,pninitial);
end;

C=2*C-1;%将扩频码映射成双极性码
N=2^length(pntaps1)-1;
M=10000;%定义每个用户传输信息比特位数
B=2*randi([0,1],K,M)-ones(K,M);%生成随机用户比特信息矩阵并映射成双极性码

A=zeros(1,N*M);
%扩频
 for i=1:K
        for j=1:M
            A((j-1)*N+1:j*N)=B(i,j)*C(i,:)+A((j-1)*N+1:j*N); %每个用户的m*N扩频结果都累加到同一m*N上(共用信道)
        end
 end
A=reshape(A,N,M);%矩阵整形为向量

%noise_power=10*log10(N)-SNR;
SNR=3;
D=awgn(A,SNR,'measured');%添加噪声

b=C*D;%解扩


errors(1,K)=countError(b,B,K,M);%统计误比特率
end;
%画图
users=1:K;
semilogy(users,errors,'b-+');
title('信噪比一定时,用户数和误码率的关系');
xlabel('用户数K');
ylabel('误比特率BER');


            

