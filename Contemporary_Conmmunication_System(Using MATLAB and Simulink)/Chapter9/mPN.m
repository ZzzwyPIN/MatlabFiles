function [pndata]=mPN(pntaps,pninitial)
%产生M序列,若本原多项式为X^6+X+1;
% pntaps=[1 0 0 0 0 1];%反馈线的状态c1-cn
%  pninitial=[0 0 0 0 0 1];%寄存器的初始状态
N=length(pntaps);%寄存器的个数
pndata=zeros(1,2^N-1);%寄存器输出向量
pnregister=pninitial;
n=0;
kk=0;
while kk == 0
    n=n+1;
    pndata(1,n)=pnregister(1,N);
    feedback=rem((pnregister*pntaps'),2);%计算反馈值,对应反馈系数为0
    pnregister=[feedback,pnregister(1,1:N-1)];
    if pnregister==pninitial
        kk=1;
    end
end
