function code=A_law13code(a)
%
n=length(a);
code=zeros(n,8);
for i=1:n
    if a(i)>=0
        code(i,1)=1;
    else
        code(i,1)=0;
    end
end
amax=max(abs(a));
a1=abs(a/amax);
a_quan=floor(a1*4096);
for x=1:n
    if (a_quan(x)>=256)
        code(x,2)=1;
        if (a_quan(x)>=1024)
            code(x,3)=1;
            if (a_quan(x)>=2048)
                code(x,4)=1;
                st=2048;
                step=128;
            else
                code(x,4)=0;
                st=1024;
                step=64;
            end;
        else
            code(x,3)=0;
            if (a_quan(x)>=512)
                code(x,4)=1;
                st=512;
                step=32;
            else
                code(x,4)=0;
                st=256;
                step=16;
            end
        end
    else
        code(x,2)=0;
        if(a_quan(x)>=64)
            code(x,3)=1;
            if(a_quan(x)>=128)
                code(x,4)=1;
                st=128;
                step=8;
            else
                code(x,4)=0;
                st=64;
                step=4;
            end
        else
            code(x,3)=0;
            if(a_quan(x)>=32)
                code(x,4)=1;
                st=32;
                step=2;
            else
                code(x,4)=0;
                st=0;
                step=2;
            end
        end
    end
    if(a_quan(x)>=4096)
        code(x,2:8)=[1 1 1 1 1 1 1];
    else
        temp=floor((a_quan(x)-st)/step);
        t=dec2bin(temp,4)-48;
        code(x,5:8)=t(1:4);
    end
end;
    
            
            
            
            
    
