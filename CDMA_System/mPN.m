function [pndata]=mPN(pntaps,pninitial)
%����M����,����ԭ����ʽΪX^6+X+1;
% pntaps=[1 0 0 0 0 1];%�����ߵ�״̬c1-cn
%  pninitial=[0 0 0 0 0 1];%�Ĵ����ĳ�ʼ״̬
N=length(pntaps);%�Ĵ����ĸ���
pndata=zeros(1,2^N-1);%�Ĵ����������
pnregister=pninitial;
n=0;
kk=0;
while kk == 0
    n=n+1;
    pndata(1,n)=pnregister(1,N);
    feedback=rem((pnregister*pntaps'),2);%���㷴��ֵ,��Ӧ����ϵ��Ϊ0
    pnregister=[feedback,pnregister(1,1:N-1)];
    if pnregister==pninitial
        kk=1;
    end
end
