function [errors]=countError(X,B,K,M)
%%%%%%%%%%%�˺����������㴫���������ʡ�����X��B�ֱ�����������õ����źź�ԭ�����źš�K�����û�����M����ÿ���û�����ı�������
Err=0;
for i=1:K
    for j=1:M
        if(X(i,j)>0)
            X(i,j)=1;
        else
            X(i,j)=-1;
        end;
        if(X(i,j)~=B(i,j))
            Err=Err+1;
        end;
    end;
end;
errors=Err./(K*M);

            