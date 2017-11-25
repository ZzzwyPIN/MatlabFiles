% Gold序列是基于m序列优选对产生的，是由两个长度相同、速率相同、
% 但码字不同的m序列优选对模2加后得到的，
% 一对长度为N的m序列优选对可以产生N＋2条Gold码。
clear
clc
%%%%%%GOLD序列的生成%%%%%%
r=6;N=2^r-1;    
s1(1:6)=[1 0 0 0 0 0];                       %initial value 1
s2(1:6)=[1 0 0 0 0 0];                       %initial value 1
f1=[1  0 0 0  0 1 1];                       %特征多项式f＝x^6+x+1;
f2=[1  1 0 0  1 1 1];                       %特征多项式f＝x^6+x^5+x^2+x+1;
for n=r+1:N                                %creat pn 1
    s1(n)=mod(sum(s1(n-r:n-1).*f1(1:r)),2);
end
for n=r+1:N                                %creat pn 2
    s2(n)=mod(sum(s2(n-r:n-1).*f2(1:r)),2);
end
s=mod(s1+s2,2); %creat pn gold
gold_sequence_1 = s;
