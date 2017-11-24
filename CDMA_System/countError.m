function [errors]=countError(X,B,K,M)
%%%%%%%%%%%此函数用来计算传输的误比特率。其中X和B分别代表解扩过后得到的信号和原传输信号。K代表用户数，M代表每个用户传输的比特数。
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

            