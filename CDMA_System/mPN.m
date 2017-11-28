function [pndata]=mPN(pntaps,pninitial)
N=length(pntaps);
pndata=zeros(1,2^N-1);
pnregister=pninitial;
n=0;
kk=0;
while kk == 0
    n=n+1;
    pndata(1,n)=pnregister(1,N);
    feedback=rem((pnregister*pntaps'),2);
    pnregister=[feedback,pnregister(1,1:N-1)];
    if isequal(pnregister,pninitial)
        kk=1;
    end
end
