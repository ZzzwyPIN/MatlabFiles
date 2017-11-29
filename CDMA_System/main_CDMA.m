clc
clear

% ����1000���룬���+1/-1 �����е���QPSK����
% M= 1000;
% for i=1:M
%     if rand < 0.5
%         code(i)=-1;
%     else
%         code(i)=1;
%     end
% end
% data;  ��Ҫ�����10000�����data,Ȼ�����QPSK����
% user ;                  �û���
%  SNR=-5:1:10;          % �����
% ml                  ���ƽ���
% nd=N; ndΪ�������ݵĸ���
%[ich, qch]  = qpskmod(s,2,10000,2); %QPSK���ƣ�ich�д�ŵ���ͬ�������qch������������
K=30;%K��ʾ�û���

connection1 =[1 0 0 0 0 1];%��һ���ͷϵ��
connection2 =[1 1 0 0 1 1];%�ڶ����ͷϵ��
% pninitial=[0 0 0 0 0 1];%�Ĵ����ĳ�ʼ״̬
goldseq = gold_sequence(connection1,connection2);
r = randi([1,63],1,30);
for i=1:K
    C(i,:) = goldseq(r(i),:);
end 

N=2^length(connection1)-1;%N��ʾ��Ƶ��ĳ���
M=10000;%M��ʾÿ���û�������������ĳ���
B=2*randi([0 1],K,M)-ones(K,M);%B��K���û�������,ÿ���û������ݳ�����N

%.................��Ƶ,�õ����Ͷ��ź�A..................
for k=1:M
 for i=1:N
    A1=0;
    for j=1:K
        A1=A1+B(j,k).*C(j,i);
    end
    A(i,k)=A1;
  end
end;

%�����˹������Ľ��
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
