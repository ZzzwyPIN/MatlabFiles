function out=A_law13decode(in)
[n,~]=size(in);
step1=[0 32 64 128 256 512 1024 2048];
step2=[2 2 4 8 16 32 64 128];
out=zeros(1,n);
for i=1:n
    sgn=2*in(i,1)-1;
    s1=4*in(i,2)+2*in(i,3)+in(i,4)+1;
    s2=8*in(i,5)+4*in(i,6)+2*in(i,7)+in(i,8);
    s3=step1(s1)+step2(s1)*s2+0.5*step2(s1);
    out(i)=sgn*s3;
end;
out=out/4096;

