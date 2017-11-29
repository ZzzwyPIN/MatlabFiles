clc
clear

% 传输1000个码，随机+1/-1 ，进行的是QPSK调制
% M= 1000;
% for i=1:M
%     if rand < 0.5
%         code(i)=-1;
%     else
%         code(i)=1;
%     end
% end
% data;  将要传输的10000个码给data,然后进行QPSK调制
% user ;                  用户数
%  SNR=-5:1:10;          % 信噪比
% ml                  调制阶数
% nd=N; nd为输入数据的个数
%[ich, qch]  = qpskmod(s,2,10000,2); %QPSK调制，ich中存放的是同向分量，qch中是正交分量
K=30;%K表示用户数

connection1 =[1 0 0 0 0 1];%第一组抽头系数
connection2 =[1 1 0 0 1 1];%第二组抽头系数
% pninitial=[0 0 0 0 0 1];%寄存器的初始状态
goldseq = gold_sequence(connection1,connection2);
r = randi([1,63],1,30);
for i=1:K
    C(i,:) = goldseq(r(i),:);
end 

N=2^length(connection1)-1;%N表示扩频码的长度
M=10000;%M表示每个用户输入的数据流的长度
B=2*randi([0 1],K,M)-ones(K,M);%B是K个用户数据流,每个用户的数据长度是N

%.................扩频,得到发送端信号A..................
for k=1:M
 for i=1:N
    A1=0;
    for j=1:K
        A1=A1+B(j,k).*C(j,i);
    end
    A(i,k)=A1;
  end
end;

%加入高斯噪声后的结果
%noise-power=10*log10(N)-SNR;
SNR=1:20;
errorrate=zeros(1,20);
for i=1:20
      errornum=0;
      D=awgn(A,SNR(i),'measured');
      b=C*D;
    
    for ii=1:30
        for jj=1:10000
            if(b(ii,jj)>0)
                b(ii,jj)=1;
            else
                b(ii,jj)=-1;
            end;
            if (b(ii,jj)~=B(ii,jj))
                errornum=errornum+1;
            end;
        end;
       % errorrate=errornum./(K*M);
    end;
    errorrate(i)=errornum./(K*M);
end;
